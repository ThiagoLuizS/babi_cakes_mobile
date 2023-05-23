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
import 'package:babi_cakes_mobile/src/features/core/service/dashboard/dashboard_service.dart';
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
  late List<CategoryView> categoryViews = [];
  late CategoryView categoryView = CategoryView();
  late int currentIndexTab = 0;
  late List<BannerView> bannerList = [];
  late bool isLoading = true;

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
    List<Tab> tabs = categoryViews.map((e) => Tab(child: Text(e.name!))).toList();
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: tabs.length,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height,
              child: bannerList.isNotEmpty
                  ? DashboardService.getScreenBannerForCategory(context, categoryView, bannerList, tabs, height, categoryViews, isLoading: isLoading)
                  : DashboardService.getScreenForCategory(context, categoryView, bannerList, tabs, height, categoryViews, isLoading: isLoading),
            ),
          )
        ]
      ),
    );
  }

  _onGetCategoryAll() async {
    setState(() {
      isLoading = true;
    });
    ApiResponse<List<CategoryView>> response =
        await _categoryBloc.getAllCategoryAndFechProduct();

    if (response.ok) {
      if (response.result.isNotEmpty && mounted) {
        response.result
            .insert(0, CategoryView(id: 0, name: "Inicio", show: false));
        TabController tab =
            TabController(length: response.result.length, vsync: this);
        setState(() {
          categoryViews = response.result;
          tabController = tab;
        });
      }
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }

    setState(() {
      isLoading = false;
    });
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
