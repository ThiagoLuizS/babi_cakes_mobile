import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_card_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

class BudgetListView extends StatefulWidget {
  const BudgetListView({Key? key}) : super(key: key);

  @override
  State<BudgetListView> createState() => _BudgetListViewState();
}

class _BudgetListViewState extends State<BudgetListView> {

  final _blocBudget = BudgetBloc();
  late ContentBudget contentBudget = ContentBudget(content: []);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blocBudget.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBudgetPageByUser();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Histórico", style: TextStyle(color: Colors.black),),
                      ),
                      ListView.builder(
                        itemCount: contentBudget.content.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              child: BudgetCardListView(budgetView: contentBudget.content[index],),
                            ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getBudgetPageByUser() async {
    ApiResponse<ContentBudget> response = await _blocBudget.getBudgetPageByUser(0, 10);

    if (response.ok) {
      setState(() {
        contentBudget = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
