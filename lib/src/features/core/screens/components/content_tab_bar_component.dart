import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/banner/banner_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/content_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_tab_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/animations/fade_in_animation/animation_design.dart';
import 'package:babi_cakes_mobile/src/utils/animations/fade_in_animation/fade_in_animation_model.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ContentTabBarComponent extends StatefulWidget {
  const ContentTabBarComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentTabBarComponent> createState() => _ContentTabBarComponentState();
}

class _ContentTabBarComponentState extends State<ContentTabBarComponent>
    with TickerProviderStateMixin {
  late TabController tabController;
  final controller = ContentController();
  final CategoryBloc _categoryBloc = CategoryBloc();
  final BannerBloc _bannerBloc = BannerBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);
  late CategoryView categoryView;
  late int currentIndexTab = 0;
  late List<BannerView> bannerList = [];

  @override
  void dispose() {
    _categoryBloc.dispose();
    _bannerBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetBannerAll();
    _onGetCategoryAll();
    tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs =
        contentCategory.content.map((e) => Tab(child: Text(e.name))).toList();
    double height = MediaQuery.of(context).size.height;
    return contentCategory.content.isNotEmpty ?
      DefaultTabController(
      length: tabs.length,
      child: bannerList.isNotEmpty
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 209, 174, 139),
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
                  Expanded(child: BannerSession(bannerList: bannerList))
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
                        children: contentCategory.content.map((e) {
                      if (e.id == 0) {
                        return DashboardComponent(
                          contentCategory: contentCategory,
                        );
                      }
                      return ProductTabComponent(categoryView: e);
                    }).toList()),
                  ),
                ),
              ),
            )
          : Padding(
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
                  children: contentCategory.content.map((e) {
                    if (e.id == 0) {
                      return DashboardComponent(
                        contentCategory: contentCategory,
                      );
                    }
                    return ProductTabComponent(categoryView: e);
                  }).toList(),
                ),
              ),
            ),
    ) :
      Scaffold(
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
  }

  _onGetCategoryAll() async {
    ApiResponse<ContentCategory> response =
        await _categoryBloc.getAllByPage(0, 10);

    if (response.ok) {
      if (response.result.content.isNotEmpty) {
        response.result.content
            .insert(0, CategoryView(id: 0, name: "Inicio", show: false));
        TabController tab =
            TabController(length: contentCategory.content.length, vsync: this);
        setState(() {
          contentCategory = response.result;
          tabController = tab;
        });
      }
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }

  _onGetBannerAll() async {
    ApiResponse<List<BannerView>> response = await _bannerBloc.getAll();

    if (response.ok) {
      setState(() {
        bannerList = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }
}
