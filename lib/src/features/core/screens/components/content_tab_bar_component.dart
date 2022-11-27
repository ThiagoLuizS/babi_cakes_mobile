import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/content_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_tab_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
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
  final _bloc = CategoryBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);
  late CategoryView categoryView;
  late int currentIndexTab = 0;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetCategoryAll();
    tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs =
        contentCategory.content.map((e) => Tab(child: Text(e.name))).toList();
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 230,
          backgroundColor: AppColors.white,
          flexibleSpace: const SizedBox(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(120)),
          ),
          actions: [Expanded(child: BannerSession())],
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
                  return const DashboardComponent();
                }
                return ProductTabComponent(categoryView: e);
              }).toList()),
            ),
          ),
        ),
      ),
    );
  }

  _refreshIndicator() {}

  _onGetCategoryAll() async {
    ApiResponse<ContentCategory> response = await _bloc.getAllByPage(0, 10);

    if (response.ok) {
      response.result.content
          .insert(0, CategoryView(id: 0, name: "Inicio", show: false));
      TabController tab =
          TabController(length: contentCategory.content.length, vsync: this);

      setState(() {
        contentCategory = response.result;
        tabController = tab;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
