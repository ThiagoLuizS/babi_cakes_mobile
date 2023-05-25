import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_group_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/category_session_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../service/dashboard/dashboard_service.dart';

class DashboardComponent extends StatefulWidget {
  final List<CategoryView> categoryViews;
  final bool isLoadingProducts;
  const DashboardComponent({Key? key, required this.categoryViews, this.isLoadingProducts = false}) : super(key: key);

  @override
  State<DashboardComponent> createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> with SingleTickerProviderStateMixin {
  late ContentCategory contentCategory = ContentCategory(content: []);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidRefreshComponent(
      onRefresh: () async => Get.offAll(() => const Dashboard()),
      child: SizedBox(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            //CategorySession(categories: widget.categoryViews, categoryBloc: _categoryBloc),
            SliverList(
              delegate: SliverChildListDelegate(
                widget.categoryViews
                    .map(
                      (e) => CategoryGroupItemComponent(
                    categoryView: _setStateCategoryView(e), isLoading: widget.isLoadingProducts),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }


  CategoryView _setStateCategoryView(CategoryView categoryView) {
    setState(() {
      categoryView = categoryView;
    });
    return categoryView;
  }
}