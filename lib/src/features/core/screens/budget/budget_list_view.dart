

import 'dart:async';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_event.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_state.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_card_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_details_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../controllers/budget/budget_bloc_state.dart';

class BudgetListView extends StatefulWidget {

  const BudgetListView({Key? key}) : super(key: key);

  @override
  State<BudgetListView> createState() => _BudgetListViewState();
}

class _BudgetListViewState extends State<BudgetListView> {
  final _blocBudget = BudgetBloc();
  late bool isLoadingBudget = true;

  late final BudgetBlocState budgetBlocState;

  @override
  void dispose() {
    budgetBlocState.close();
    _blocBudget.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    budgetBlocState = BudgetBlocState();
    budgetBlocState.add(LoadBudgetEvent(page: 0, size: 50));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => Get.offAll(() => const Dashboard(indexBottomNavigationBar: 0)),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.berimbau,
          ),
        ),
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBarDefaultComponent(
              title: "Pedidos",
            )),
        backgroundColor: Colors.white,
        body: LiquidRefreshComponent(
          onRefresh: () => budgetBlocState.add(LoadBudgetEvent(page: 0, size: 50)),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          BlocBuilder<BudgetBlocState, BudgetState>(
                              bloc: budgetBlocState,
                              buildWhen: (previousState, state) {
                                return true;
                              },
                              builder: (context, state) {
                                final contentBudget = state.contentBudget;
                                final itemCount = contentBudget!.content.length;

                                if(state is BudgetErrorState) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    var data = state.error;
                                    alertToast(context, data, 3, Colors.grey, false);
                                  });
                                }

                                if(state.isLoading) {
                                  return ShimmerComponent(
                                    isLoading: true,
                                    child: SizedBox(width: double.infinity, height: 200, child: Container(decoration: BoxDecoration(color: AppColors.grey3),)),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: itemCount,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) =>
                                      GestureDetector(
                                        child:BudgetCardListView(
                                          budgetView: contentBudget.content[index],
                                        ),
                                      ),
                                );
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
