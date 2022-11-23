import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/search_product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productBloc.dispose();
  }

  @override
  void initState() {
    _onGetProductAll(widget.categoryView!.id, productName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        return _refreshIndicator();
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: SearchProductComponent(
                  filterController: filterController,
                  productBloc: _productBloc,
                  onPressed: () {
                    _onGetProductAll(
                        widget.categoryView!.id, filterController.text);
                  },
                ),
              ),
              SizedBox(
                height: height,
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.60),
                  itemCount: contentProduct.content.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        push(context, Product(productView: contentProduct.content[index]), replace: true);
                      },
                      child: ProductComponent(
                          productView: contentProduct.content[index],
                          isLoading: isLoading),
                    );
                  },
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  _refreshIndicator() {
    _onGetProductAll(widget.categoryView!.id, productName);
  }

  _onGetProductAll(int categoryId, String productName) async {
    setState(() {
      isLoading = true;
    });
    ApiResponse<ContentProduct> response =
        await _productBloc.getAllByPage(0, 10, categoryId, productName);

    if (response.ok) {
      setState(() {
        contentProduct = response.result;
        isLoading = false;
      });
    }
    return ContentProduct(content: []);
  }
}
