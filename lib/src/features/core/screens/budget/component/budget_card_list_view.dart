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
    double height = MediaQuery.of(context).size.height;
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
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                top: BorderSide(width: 1, color: Color(0x32989191)),
                bottom: BorderSide(width: 1, color: Color(0x32989191)),
                left: BorderSide(width: 1, color: Color(0x32989191)),
                right: BorderSide(width: 1, color: Color(0x32989191)),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x32989191),
                  offset: Offset(0.4, 0.4),
                  blurRadius: 0.4,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
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
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Pedido Nº ${budgetView.code}',
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
                  const Divider(color: AppColors.grey),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        _iconByStatus(budgetView.budgetStatusEnum.type),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: ListView.builder(
                      itemCount: budgetView.productReservedViewList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: const Color(
                                    0x6F9E9E9D)),
                                height: 15,
                                width: 15,
                                child: Center(child: Text(index.toString(), style: const TextStyle(fontSize: 10),)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    budgetView.productReservedViewList[index]
                                        .productView.name.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Icon _iconByStatus(String type) {
    Icon icon = const Icon(
      Icons.watch_later_outlined,
      size: 15,
      color: Colors.grey,
    );
    switch (type) {
      case 'AWAITING_PAYMENT':
        icon = const Icon(
          Icons.watch_later_outlined,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'PAID_OUT':
        icon = const Icon(
          Icons.check_circle_outline,
          size: 15,
          color: Colors.green,
        );
        break;
      case 'PREPARING_ORDER':
        icon = const Icon(
          Icons.receipt_long,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'WAITING_FOR_DELIVERY':
        icon = const Icon(
          Icons.car_crash_sharp,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'ORDER_IS_OUT_FOR_DELIVERY':
        icon = const Icon(
          Icons.car_crash_sharp,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'ORDER_DELIVERED':
        icon = const Icon(
          Icons.check_circle_outline,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'CANCELED_ORDER':
        icon = const Icon(
          Icons.cancel_outlined,
          size: 15,
          color: Colors.red,
        );
        break;
    }
    return icon;
  }
}
