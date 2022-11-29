import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_card_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class BudgetListView extends StatefulWidget {
  const BudgetListView({Key? key}) : super(key: key);

  @override
  State<BudgetListView> createState() => _BudgetListViewState();
}

class _BudgetListViewState extends State<BudgetListView> {
  final _blocBudget = BudgetBloc();
  late ContentBudget contentBudget = ContentBudget(content: []);

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  void dispose() {
    super.dispose();
    _blocBudget.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getBudgetPageByUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  contentBudget.content.isNotEmpty ? Padding(
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
                            child: BudgetCardListView(
                              budgetView: contentBudget.content[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : MessageComponent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBudgetPageByUser() async {
    ApiResponse<ContentBudget> response =
        await _blocBudget.getBudgetPageByUser(0, 10);

    if (response.ok) {
      setState(() {
        contentBudget = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
