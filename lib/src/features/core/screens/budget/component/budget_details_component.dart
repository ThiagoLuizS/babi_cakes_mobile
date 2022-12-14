import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_data.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserved_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/budget_linear_progress_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/paypal_payment_button_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/whatsapp_button_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class BudgetDetailsComponent extends StatefulWidget {
  final BudgetView budgetView;

  const BudgetDetailsComponent({Key? key, required this.budgetView})
      : super(key: key);

  @override
  State<BudgetDetailsComponent> createState() => _BudgetDetailsComponentState();
}

class _BudgetDetailsComponentState extends State<BudgetDetailsComponent>
    with TickerProviderStateMixin {
  final BudgetData budgetData = BudgetData();
  final BudgetBloc _blocBudget = BudgetBloc();
  late BudgetView budgetView;
  late Timer _timer;

  @override
  void dispose() {
    _blocBudget.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      budgetView = widget.budgetView;
    });
    _timer = _schedulerEvent();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarDefaultComponent(
            title: "Detalhes do pedido",
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Get.offAll(() => const Dashboard(indexBottomNavigationBar: 2)),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.berimbau,
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Row(
                            children: [
                              const Image(image: AssetImage(tSplashImage), width: 100, height: 100,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Babi cakes", style: TextStyle(color: Colors.black87, fontSize: 18),),
                                  Text('Pedido nº ${budgetView.code} * ${DateFormat.yMd().add_jm().format(budgetView.dateCreateBudget)}', style: TextStyle(color: Color.fromARGB(109, 0, 0, 0), fontSize: 14),),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            decoration: budgetView.budgetStatusEnum.type == BudgetService.paidOut ?
                            BoxDecoration(color: Colors.green[400], borderRadius: BorderRadius.circular(8)) :
                            BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(8)),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                budgetData.iconByStatus(
                                    budgetView.budgetStatusEnum.type),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    budgetView.budgetStatusEnum.status,
                                    style: budgetView.budgetStatusEnum.type == BudgetService.paidOut ?
                                    const TextStyle(color: Colors.white) :
                                    const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        BudgetLinearProgressComponent(budgetView: budgetView,),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                budgetView.productReservedViewList.length,
                                itemBuilder: (BuildContext itemBuilder, index) {
                                  BudgetProductReservedView reserved = widget
                                      .budgetView.productReservedViewList[index];
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(
                                                  base64Decode(reserved
                                                      .productView
                                                      .productFileView
                                                      .photoBase64ToString),
                                                )),
                                            borderRadius: BorderRadius.circular(10),
                                            color: tCardBgColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Text(
                                              reserved.productView.name.toUpperCase(),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(167, 0, 0, 0),
                                                  fontSize: 11,
                                                  overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 6),
                                        child: Text(
                                          '${reserved.quantity}x',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        UtilBrasilFields.obterReal(
                                            reserved.productView.value -
                                                reserved.productView.discountValue,
                                            moeda: true,
                                            decimal: 2),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                              height: 1, color: Color.fromARGB(94, 0, 0, 0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Resumo de valores",
                                style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Subtotal",
                                      style: TextStyle(
                                          color: Color.fromARGB(141, 0, 0, 0),
                                          fontSize: 14),
                                    ),
                                    Text(
                                      UtilBrasilFields.obterReal(
                                          budgetView.subTotal,
                                          moeda: true,
                                          decimal: 2),
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Taxa de entrega",
                                      style: TextStyle(
                                          color: Color.fromARGB(94, 0, 0, 0),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      UtilBrasilFields.obterReal(
                                          budgetView.freightCost,
                                          moeda: true,
                                          decimal: 2),
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              budgetView.cupom != null ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Cupom",
                                      style: TextStyle(
                                          color: Color.fromARGB(94, 0, 0, 0),
                                          fontSize: 12),
                                    ),
                                    Text(
                                      UtilBrasilFields.obterReal(
                                          budgetView.cupom.cupomValue,
                                          moeda: true,
                                          decimal: 2),
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    )
                                  ],
                                ),
                              ) : Container(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                          color: Color.fromARGB(190, 0, 0, 0),
                                          fontSize: 14),
                                    ),
                                    Text(
                                      UtilBrasilFields.obterReal(
                                          budgetView.amount,
                                          moeda: true,
                                          decimal: 2),
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 20),
                          child: Divider(
                              height: 1, color: Color.fromARGB(94, 0, 0, 0)),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Forma de pagamento",
                                style: TextStyle(
                                    color: Color.fromARGB(229, 0, 0, 0),
                                    fontSize: 13),
                              ),
                              Image(
                                  image: AssetImage(tPayPalImage),
                                  width: 100,
                                  height: 25,
                                  color: AppColors.berimbau)
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Divider(
                              height: 1, color: Color.fromARGB(94, 0, 0, 0)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Endereço da entrega",
                            style: TextStyle(
                                color: Color.fromARGB(94, 0, 0, 0), fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            '${budgetView.address.addressType} ${budgetView.address.addressName}, ${budgetView.address.number} - ${budgetView.address.complement}',
                            style: const TextStyle(
                                color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            '${budgetView.address.district} - ${budgetView.address.city} - ${budgetView.address.state}',
                            style: const TextStyle(
                                color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
                          ),
                        ),
                        budgetView.budgetStatusEnum.type == BudgetService.awaitPayment ? Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                          child: PixPaymentButtonComponent(budgetView: budgetView),
                        ) : WhatsappButtonComponent(budgetView: budgetView),
                      ],
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  Timer _schedulerEvent() {
    return Timer.periodic(const Duration(seconds: 5), (timer) {
      _getEventPixPayment();
    });
  }


  _getBudgetByUserAndById() async {
    ApiResponse<BudgetView> response =
        await _blocBudget.getBudgetByUserAndById(budgetView.id);

    if (response.ok) {
      setState(() {
        budgetView = response.result;
      });
    } else {
      // ignore: use_build_context_synchronously
      alertToast(context, response.erros[0].toString(), 8, Colors.grey, false);
    }
  }

  _getEventPixPayment() async {
    Future<EventMessageView?> event = EventMessageView.get();
    event.then((value) {
      if(value != null) {
        EventMessageView.clear();
        _getBudgetByUserAndById();
      }
    });
  }
}
