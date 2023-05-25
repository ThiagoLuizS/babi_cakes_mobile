import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/banner/banner_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/content_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_tab_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session_view.dart';
import 'package:babi_cakes_mobile/src/features/core/service/dashboard/dashboard_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/animations/fade_in_animation/animation_design.dart';
import 'package:babi_cakes_mobile/src/utils/animations/fade_in_animation/fade_in_animation_model.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../controllers/banner/banner_event.dart';
import '../../controllers/category/category_event.dart';
import '../dashboard/widgets/category_session_view.dart';
import '../dashboard/widgets/group_product_session.dart';
import 'category_group_item_component.dart';
import 'liquid_refresh_component.dart';

class ContentTabBarComponent extends StatefulWidget {
  const ContentTabBarComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentTabBarComponent> createState() => _ContentTabBarComponentState();
}

class _ContentTabBarComponentState extends State<ContentTabBarComponent>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _loadFetchEventAll();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: LiquidRefreshComponent(
        onRefresh: () {
          _loadFetchEventAll();
        },
        child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: const [
                    BannerSessionView(),
                    CategorySessionView(),
                    GroupProductSessionView()
                  ],
                )
              ),
            ]
        ),
      ),
    );
  }

  _loadFetchEventAll() {
    BlocProvider.of<BannerBloc>(context).add(LoadBannerEvent());
    BlocProvider.of<CategoryBloc>(context).add(LoadCategoryFetchEvent());
  }
}
