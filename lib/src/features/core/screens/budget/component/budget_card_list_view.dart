import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_data.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_details_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class BudgetCardListView extends StatefulWidget {
  final BudgetView budgetView;

  const BudgetCardListView({Key? key, required this.budgetView})
      : super(key: key);

  @override
  State<BudgetCardListView> createState() => _BudgetCardListViewState();
}

class _BudgetCardListViewState extends State<BudgetCardListView> {
  final BudgetData budgetData = BudgetData();

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
              DateFormat('dd/MM/yyyy HH:mm').format(widget.budgetView.dateCreateBudget),
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Get.offAll(() => BudgetDetailsComponent(budgetView: widget.budgetView)),
          child: Padding(
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
                                'Pedido Nº ${widget.budgetView.code}',
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
                          budgetData.iconByStatus(widget.budgetView.budgetStatusEnum.type),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.budgetView.budgetStatusEnum.status,
                              style: const TextStyle(
                                  color: tSecondaryColorV1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListView.builder(
                          itemCount: widget.budgetView.productReservedViewList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            child: SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: const Color(0x6F9E9E9D)),
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                        child: Text(
                                      index.toString(),
                                      style: const TextStyle(fontSize: 10),
                                    )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        widget.budgetView.productReservedViewList[index]
                                            .productView.name
                                            .toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: BorderSide.none, foregroundColor: AppColors.grey3),
                          onPressed: () => Get.offAll(() => BudgetDetailsComponent(budgetView: widget.budgetView)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Text("Veja mais", style: TextStyle(color: AppColors.berimbau),),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
