import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/search_product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductTabComponent extends StatefulWidget {
  final CategoryView? categoryView;

  const ProductTabComponent({Key? key, required this.categoryView})
      : super(key: key);

  @override
  State<ProductTabComponent> createState() => _ProductTabComponentState();
}

class _ProductTabComponentState extends State<ProductTabComponent> {
  late ContentProduct contentProduct = ContentProduct(content: []);
  final ProductBloc _productBloc = ProductBloc();
  late bool isLoading = true;
  late String productName = '';
  late TextEditingController filterController = TextEditingController();
  int pageSize = 4;

  @override
  void dispose() {
    super.dispose();
    _productBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetProductAll(widget.categoryView!.id, productName, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        return _refreshIndicator();
      },
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 10),
              child: SearchProductComponent(
                filterController: filterController,
                productBloc: _productBloc,
                onPressed: () {
                  _onGetProductAll(
                      widget.categoryView!.id, filterController.text, pageSize);
                },
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) => onNotification(scrollNotification),
                child: StreamBuilder<Object>(
                  stream: _productBloc.stream,
                  builder: (context, snapshot) {
                    return GridView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.60),
                      scrollDirection: Axis.vertical,
                      itemCount: contentProduct.content.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            push(
                                context,
                                Product(
                                    productView: contentProduct.content[index]),
                                replace: true);
                          },
                          child: ProductComponent(
                              productView: contentProduct.content[index],
                              isLoading: isLoading),
                        );
                      },
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is OverscrollNotification && !isLoading) {
      _onGetProductAll(widget.categoryView!.id, productName, pageSize += 1);
    }
    return false;
  }

  _refreshIndicator() {
    _onGetProductAll(widget.categoryView!.id, productName, pageSize);
  }

  _onGetProductAll(int categoryId, String productName, pageSize) async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentProduct> response = await _productBloc.getAllByPage(
        0, pageSize, categoryId, productName);

    if (response.ok) {
      setState(() {
        contentProduct = response.result;
        isLoading = false;
      });
    }
  }
}
