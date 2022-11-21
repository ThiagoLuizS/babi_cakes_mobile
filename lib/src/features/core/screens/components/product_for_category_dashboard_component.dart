import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:flutter/material.dart';

class ProductForCategoryDashboardComponent extends StatefulWidget {
  final ProductView productView;
  final bool isLoadingProducts;

  const ProductForCategoryDashboardComponent({
    Key? key,
    required this.txtTheme, required this.productView, required this.isLoadingProducts,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  State<ProductForCategoryDashboardComponent> createState() => _ProductForCategoryDashboardComponentState();
}

class _ProductForCategoryDashboardComponentState extends State<ProductForCategoryDashboardComponent> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
      child: ProductComponent(productView: widget.productView, isLoading: widget.isLoadingProducts,),
    );
  }
}
