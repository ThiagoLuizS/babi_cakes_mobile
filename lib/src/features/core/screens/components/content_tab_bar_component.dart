import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_tab_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ContentTabBarComponent extends StatelessWidget {
  final TabController controller;
  final List<CategoryView> content;
  final ContentProduct contentProduct = ContentProduct(content: []);

  ContentTabBarComponent({
    Key? key,
    required this.controller,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = content.map((e) => Tab(child: Text(e.name))).toList();
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        return _refreshIndicator();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: TabBar(
              onTap: (index) {},
              indicatorPadding: EdgeInsets.zero,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelColor: AppColors.berimbau,
              unselectedLabelColor: AppColors.black54,
              labelStyle: AppTypography.tabBarStyle(context),
              indicator: MaterialIndicator(
                color: AppColors.berimbau,
                height: 5,
                bottomLeftRadius: 5,
                bottomRightRadius: 5,
              ),
              isScrollable: true,
              tabs: tabs,
            ),
            body: TabBarView(
              children: content.map((e) {
                if(e.id == 0) {
                  return const DashboardComponent();
                }
                return ProductTabComponent(categoryView: e);
              }).toList()
            ),
          ),
        ),
      ),
    );
  }

  _refreshIndicator() {

  }
}




