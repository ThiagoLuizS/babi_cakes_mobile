import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetCardListView extends StatelessWidget {
  final BudgetView budgetView;

  const BudgetCardListView({Key? key, required this.budgetView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat.yMMMEd().format(budgetView.dateCreateBudget),
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              border: const Border(
                top: BorderSide(width: 1, color: Color(0x32989191)),
                bottom: BorderSide(width: 1, color: Color(0x32989191)),
                left: BorderSide(width: 1, color: Color(0x32989191)),
                right: BorderSide(width: 1, color: Color(0x32989191)),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x32989191),
                  offset: Offset(0.1, 0.1),
                  blurRadius: 0.4,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: AppColors.berimbau,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Pedido de número Nº ${budgetView.code}',
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColors.black),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.black54),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                              size: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                budgetView.budgetStatusEnum.status,
                                style: const TextStyle(
                                    color: tSecondaryColorV1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
