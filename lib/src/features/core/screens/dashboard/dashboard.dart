import 'dart:async';

import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/budget_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/content_tab_bar_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/bottom_navigation_bar_footer.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/bottom_navigation_bar_header.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/open_shop.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_search.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/profile_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/shopping_cart/shopping_cart_component.dart';
import 'package:babi_cakes_mobile/src/features/core/service/event/providers_service.dart';
import 'package:babi_cakes_mobile/src/features/core/service/notification/notification_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/parameterization/parameterization_bloc.dart';
import '../../controllers/parameterization/parameterization_event.dart';
import '../../controllers/parameterization/parameterization_state.dart';

class Dashboard extends StatefulWidget {
  final int indexBottomNavigationBar;

  const Dashboard({Key? key, this.indexBottomNavigationBar = 0})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final ParameterizationBloc blocParameterization;

  @override
  void dispose() {
    blocParameterization.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    blocParameterization = ParameterizationBloc();

    _getParameterization();
    _getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Consumer<ShoppingCartController>(builder: (context, cart, child) {
        return BlocConsumer<ParameterizationBloc, ParameterizationState>(
          bloc: blocParameterization,
          listener: (context, state) {
            if(!state.parameterizationView.openShop!) {
              Get.offAll(() => const OpenShop());
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.white,
              extendBody: true,
              bottomNavigationBar: BottomNavigationBarHeader(cart: cart),
              body: const DefaultTabController(
                length: 4,
                child: Scaffold(
                  bottomNavigationBar: BottomNavigationFooter(),
                  body: TabBarView(
                    children: [
                       ContentTabBarComponent(),
                       ProductSearch(),
                       BudgetListView(),
                       ProfileScreen()
                    ],
                  )
                ),
              ),
            );
          }
        );
      }),
    );
  }

  _getParameterization() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if(mounted) {
        blocParameterization.add(LoadParameterizationEvent());
      }
    });
  }

  _getEvent() {
      getIt<EventBus>().on<EventMessageView>().listen((event) {
        _pushNotification(event);
      });
  }

  _pushNotification(EventMessageView event) {
    if(mounted) {
      Provider.of<NotificationService>(context, listen: false).showNotification(event);
    }
  }
}
