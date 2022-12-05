import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
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
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class BudgetListView extends StatefulWidget {

  const BudgetListView({Key? key}) : super(key: key);

  @override
  State<BudgetListView> createState() => _BudgetListViewState();
}

class _BudgetListViewState extends State<BudgetListView> {
  final _blocBudget = BudgetBloc();
  late ContentBudget contentBudget = ContentBudget(content: []);
  late bool isLoadingBudget = true;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  void dispose() {
    _blocBudget.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLoadingBudget = true;
    _getBudgetPageByUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
          onRefresh: () => _getBudgetPageByUser(),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    !isLoadingBudget ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Histórico",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListView.builder(
                            itemCount: contentBudget.content.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                              child: ShimmerComponent(
                                isLoading: isLoadingBudget,
                                child: BudgetCardListView(
                                  budgetView: contentBudget.content[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : ShimmerComponent(child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(height: 200, color: Colors.black,),
                          )),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getBudgetPageByUser() async {
    setState(() {
      isLoadingBudget = true;
    });

    ApiResponse<ContentBudget> response =
        await _blocBudget.getBudgetPageByUser(0, 10);

    if (response.ok) {
      setState(() {
        contentBudget = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }

    setState(() {
      isLoadingBudget = false;
    });
  }
}
