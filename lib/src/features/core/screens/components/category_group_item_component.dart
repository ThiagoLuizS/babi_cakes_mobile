import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_for_category_dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';

class CategoryGroupItemComponent extends StatefulWidget {
  final CategoryView categoryView;

  const CategoryGroupItemComponent(
      {Key? key,
      required this.categoryView})
      : super(key: key);

  @override
  _CategoryGroupItemComponentState createState() =>
      _CategoryGroupItemComponentState();
}

class _CategoryGroupItemComponentState
    extends State<CategoryGroupItemComponent> {
  final CategoryBloc _bloc = CategoryBloc();
  final ProductBloc _productBloc = ProductBloc();
  late ContentProduct contentProduct = ContentProduct(content: []);
  late bool isLoadingProducts = true;
  late String productName = '';
  int pageSize = 4;

  @override
  void initState() {
    super.initState();
    _onGetProductAll(widget.categoryView.id, productName, pageSize);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _productBloc.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return contentProduct.content.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 10),
              child: Text(
                widget.categoryView.name,
                style: AppTypography.sessionTitle(
                  context,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 10),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "Ver mais",
                  style: TextStyle(fontSize: 13, color: AppColors.berimbau),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 320,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) => onNotification(scrollNotification),
                  child: ListView.builder(
                    itemCount: contentProduct.content.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          onTap: () {
                            push(context, Product(productView: contentProduct.content[index]), replace: true);
                          },
                      child: SizedBox(
                        height: 260,
                        child: ProductForCategoryDashboardComponent(
                          isLoadingProducts: isLoadingProducts,
                          productView: contentProduct.content[index],
                          txtTheme: txtTheme,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ) : Container();
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification && !isLoadingProducts && scrollInfo.metrics.pixels ==
        scrollInfo.metrics.maxScrollExtent) {
      _onGetProductAll(widget.categoryView!.id, productName, pageSize += 1);
    }
    return false;
  }

  _onGetProductAll(int categoryId, String productName, pageSize) async {
    setState(() {
      isLoadingProducts = true;
    });
    ApiResponse<ContentProduct> response =
    await _productBloc.getAllByCategoryPage(0, pageSize, categoryId, productName, '');

    if (response.ok) {
      setState(() {
        isLoadingProducts = false;
        contentProduct = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
