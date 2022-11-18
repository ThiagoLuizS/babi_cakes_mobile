import 'package:babi_cakes_mobile/src/features/core/controllers/content_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/bottom_navigator.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/category_session.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/content_tab_bar_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/header_location_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_group_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

import '../../controllers/category/category_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final controller = ContentController();
  final _bloc = CategoryBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);

    _onGetCategoryAll();

    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Variables
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; //Dark mode

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innetBoxScroll) {
            return [
              const HeaderLocationComponent(
                location: 'Rua Flores do Campo, Bariri - São Paulo',
              ),
              ContentTabBarComponent(
                content: contentCategory.content,
                controller: tabController,
                onTap: (index) {},
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    return _refreshIndicator();
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      CategorySession(categories: contentCategory.content),
                      BannerSession(),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          contentCategory.content
                              .map((e) => CategoryGroupItemComponent(
                                    categoryView: e, itemCount: contentCategory.content.length, categoryViewList: contentCategory.content,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomNavigator(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _refreshIndicator() {
    _onGetCategoryAll();
  }

  _onGetCategoryAll() async {
    ApiResponse<ContentCategory> response = await _bloc.getAllByPage(0, 10);

    if (response.ok) {
      setState(() {
        contentCategory = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}




