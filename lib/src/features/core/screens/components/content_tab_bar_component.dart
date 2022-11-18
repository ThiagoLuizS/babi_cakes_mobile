import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ContentTabBarComponent extends StatelessWidget {
  final TabController controller;
  final List<CategoryView> content;
  final Function(int) onTap;

  const ContentTabBarComponent({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _ContentTabBarComponentDelegate(controller, onTap, content),
    );
  }
}

class _ContentTabBarComponentDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  final Function(int) onTap;
  final List<CategoryView> content;

  _ContentTabBarComponentDelegate(this.controller, this.onTap, this.content);



  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    List<Tab> tabs = [const Tab(child: Text('Início'))];
    tabs.addAll(content.map((e) => Tab(child: Text(e.name))).toList());

    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TabBar(
        onTap: onTap,
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
        controller: controller,
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }

  //content.map((e) => Tab(child: Text(e.name))).toList()

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
