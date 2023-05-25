import 'dart:async';

import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../models/banner/banner_view.dart';
import '../../screens/components/dashboard_component.dart';
import '../../screens/components/product_tab_component.dart';
import '../../screens/dashboard/widgets/banner_session_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class DashboardService {

  static getScreenPresentationNoProduct() {
    Widget widget = Container();
    Timer.periodic(Duration.zero, (timer) {
      widget = Scaffold(
        backgroundColor: AppColors.milkCream,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 220,
              child: Image(image: AssetImage(tSplashImage)),
            ),
            Text("Estamos preparando tudo e em breve estaremos disponivel!",
              style: TextStyle(color: AppColors.berimbau, fontSize: 30), textAlign: TextAlign.center,)
          ],
        ),
      );
    });

    return widget;

  }

  static getScreenForCategory(BuildContext context,
      CategoryView categoryView,
      List<BannerView> bannerList,
      List<Tab> tabs,
      double height,
      List<CategoryView> categoryViews, {required bool isLoading}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
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
          children: categoryViews.map((e) {
            if (e.id == 0) {
              return DashboardComponent(
                categoryViews: categoryViews,
                isLoadingProducts: isLoading,
              );
            }
            return ProductTabComponent(categoryView: e);
          }).toList(),
        ),
      ),
    );
  }

  static getScreenBannerForCategory(BuildContext context,
      CategoryView categoryView,
      List<BannerView> bannerList,
      List<Tab> tabs,
      double height,
      List<CategoryView> categoryViews, {required bool isLoading}) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 209, 174, 139),
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 306,
        flexibleSpace: const SizedBox(),
        shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(bottom: Radius.circular(700)),
        ),
        actions: [
          //Expanded(child: BannerSession(bannerList: bannerList))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
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
          body: SizedBox(
            height: height,
            child: TabBarView(
                children: categoryViews!.map((e) {
                  if (e.id == 0) {
                    return DashboardComponent(
                      categoryViews: categoryViews,
                    );
                  }
                  return ProductTabComponent(categoryView: e);
                }).toList()),
          ),
        ),
      ),
    );
  }
}