

import 'dart:async';

import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_event.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/general/alert.dart';
import '../../../../../utils/general/api_response.dart';
import '../../../controllers/budget/budget_bloc_state.dart';
import '../../../controllers/budget/budget_event.dart';
import '../../../controllers/budget/budget_state.dart';
import '../../../controllers/parameterization/parameterization_bloc.dart';
import '../../../controllers/parameterization/parameterization_state.dart';
import '../../../controllers/shopping_cart/shopping_cart_controller.dart';
import '../../../models/budget/budget_body_send.dart';
import '../../../models/cupom/cupom_view.dart';
import '../../../models/profile/address_view.dart';
import '../../../service/budget/budget_service.dart';
import '../../../theme/app_colors.dart';
import '../../budget/component/budget_details_component.dart';
import 'package:get/get.dart';

class BottomNavigatorShoppingCart extends StatefulWidget {
  final AddressView? addressView;

  const BottomNavigatorShoppingCart({Key? key, required this.addressView}) : super(key: key);

  @override
  State<BottomNavigatorShoppingCart> createState() => _BottomNavigatorShoppingCartState();
}

class _BottomNavigatorShoppingCartState extends State<BottomNavigatorShoppingCart> {
  late double freightCost = 0.0;
  late final BudgetBlocState budgetBlocState;
  late bool isLoadingBudget = true;
  late final ParameterizationBloc blocParameterization;

  @override
  void initState() {
    super.initState();

    blocParameterization = ParameterizationBloc();
    budgetBlocState = BudgetBlocState();

    blocParameterization.add(LoadParameterizationEvent());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _listenBloc();
    });
  }

  @override
  void dispose() {
    blocParameterization.close();
    budgetBlocState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
        builder: (context, cart, child) {
          return BlocBuilder<ParameterizationBloc, ParameterizationState>(
            bloc: blocParameterization,
            buildWhen: (previousState, state) {
              return true;
            },
            builder: (context, state) {
              late double freightCost = state.parameterizationView.freightCost!;

              return Container(
                height: 150,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x32989191),
                        offset: Offset(0.4, 0.4),
                        blurRadius: 1.4,
                        spreadRadius: 1.4,
                      ),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total com a entrega",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text(
                            UtilBrasilFields.obterReal(
                                cart.totalPrice + freightCost - (cart.cupomView != null ? cart.cupomView!.cupomValue : 0.0),
                                moeda: true,
                                decimal: 2),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          RotationTransition(
                            turns: const AlwaysStoppedAnimation(90 / 360),
                            child: IconButton(
                                onPressed: () => {_showBarAmountDetails(cart.totalPrice, freightCost, cart.cupomView)},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 15,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: isLoadingBudget
                              ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.berimbau,
                                side: BorderSide.none),
                            onPressed: () {
                              _createNewOrder(cart);
                            },
                            child: const Text("Continuar"),
                          )
                              : const SizedBox(
                            height: 25,
                            child: Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                    color: AppColors.berimbau),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        }
    );
  }

  _showBarAmountDetails(double subtotal, double freightCost, CupomView? cupomView) {
    Future<void> future = showBarModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 10),
                  child: Text("Resumo de valores", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text(UtilBrasilFields.obterReal(
                          subtotal,
                          moeda: true,
                          decimal: 2))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Taxa de entrega"),
                      Text(UtilBrasilFields.obterReal(
                          freightCost,
                          moeda: true,
                          decimal: 2))
                    ],
                  ),
                ),
                cupomView != null ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cupom"),
                      Text(UtilBrasilFields.obterReal(
                          cupomView.cupomValue,
                          moeda: true,
                          decimal: 2))
                    ],
                  ),
                ) : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(UtilBrasilFields.obterReal(
                          subtotal + freightCost - (cupomView != null ? cupomView.cupomValue : 0.0),
                          moeda: true,
                          decimal: 2), style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    future.then((value) => {});
  }

  _createNewOrder(ShoppingCartController cart) async {
    if (widget.addressView == null){
      alertToast(context, "Cadastre um endereço para continuar", 3, Colors.grey, false);
    } else{
      BudgetBodySend budgetBodySend = BudgetService.createOrderForSend(cart.items, cart.cupomView);
      budgetBlocState.add(CreateNewOrder(budgetBodySend: budgetBodySend));
      cart.removeAll();
    }
  }

  _listenBloc() {
    budgetBlocState.stream.listen((event) {
      if(event is BudgetErrorState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          var data = event.error;
          alertToast(context, data, 3, Colors.grey, false);
        });
      } else if(event is BudgetSuccessViewState) {
        Get.offAll(BudgetDetailsComponent(budgetView: event.budgetView));
      }
    });
  }
}
