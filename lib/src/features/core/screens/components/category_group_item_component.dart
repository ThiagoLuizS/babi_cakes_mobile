import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_for_category_dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_list_category.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryGroupItemComponent extends StatefulWidget {
  final CategoryView categoryView;
  final bool isLoading;

  const CategoryGroupItemComponent(
      {Key? key,
      required this.categoryView, required this.isLoading})
      : super(key: key);

  @override
  _CategoryGroupItemComponentState createState() =>
      _CategoryGroupItemComponentState();
}

class _CategoryGroupItemComponentState
    extends State<CategoryGroupItemComponent> {
  late String productName = '';
  int pageSize = 4;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return widget.categoryView.productViews != null && widget.categoryView.productViews!.isNotEmpty ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 10),
              child: Text(
                widget.categoryView.name!,
                style: const TextStyle(fontSize: 14, color: AppColors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 10),
              child: GestureDetector(
                onTap: () => Get.offAll(() => ProductListCategory(categoryView: widget.categoryView)),
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
                    itemCount: widget.categoryView.productViews?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                          onTap: () => Get.offAll(() => Product(productView: widget.categoryView.productViews![index])),
                      child: ProductForCategoryDashboardComponent(
                        isLoadingProducts: widget.isLoading,
                        productView: widget.categoryView.productViews![index],
                        txtTheme: txtTheme,
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
    if (scrollInfo is ScrollEndNotification && scrollInfo.metrics.pixels ==
        scrollInfo.metrics.maxScrollExtent) {
    }
    return false;
  }
}
