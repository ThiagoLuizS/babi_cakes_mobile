import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_body_send.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/shopping_cart/shopping_cart.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/budget_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_details_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/body_cupom_cart_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/component/profile_address_description_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_icons.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BodyShowBarShoppingCartComponent extends StatefulWidget {
  const BodyShowBarShoppingCartComponent({Key? key}) : super(key: key);

  @override
  State<BodyShowBarShoppingCartComponent> createState() =>
      _BodyShowBarShoppingCartComponentState();
}

class _BodyShowBarShoppingCartComponentState
    extends State<BodyShowBarShoppingCartComponent> {
  late ContentCupom contentCupom = ContentCupom(content: []);
  final BudgetBloc _blocBudget = BudgetBloc();
  final ParameterizationBloc _blocParameterization = ParameterizationBloc();
  final ProfileBloc _blocProfile = ProfileBloc();
  AddressView? addressView;
  late bool isLoading = true;
  late bool isLoadingBudget = true;
  late double freightCost = 0.0;

  @override
  void dispose() {
    _blocBudget.dispose();
    _blocProfile.dispose();
    _blocParameterization.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isLoading = true;
    isLoadingBudget = true;
    freightCost = 0.0;
    _getAddressMain();
    _getCupomByUserAndCupomStatusEnum();
    _getFreightCost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          Navigator.pop(context);
        }
        return Scaffold(
          body: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: width / 4),
                              child: IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: const Icon(
                                      Icons.arrow_downward_outlined)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width / 4),
                              child: const Text(
                                "SACOLA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cart.removeAll();
                                },
                                icon:
                                    const Icon(Icons.delete_outline_outlined)),
                          ],
                        ),
                        ShimmerComponent(
                          isLoading: isLoading,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: addressView != null
                                  ? [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: AppIcon(
                                          AppIcons.mapShoppingCart,
                                          color: AppColors.milkCream,
                                          size: Size(70, 70),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Text(
                                                "Entregar em",
                                                style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            ProfileAddressDescriptionComponent(
                                              addressView: addressView!,
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offAll(() =>
                                          const ProfileAddressScreen());
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.red,
                                          size: 17,
                                        ),
                                      )
                                    ]
                                  : [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.greyTransp100,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Colors.red)),
                                            onPressed: () => Get.offAll(() =>
                                                const ProfileAddressScreen()),
                                            child: const Text(
                                              "Cadastre um endereço",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(6),
                                child: Divider(color: AppColors.grey),
                              ),
                              BodyCupomCartComponent(contentCupom: contentCupom, subTotalOrder: cart.totalPrice),
                              const Padding(
                                padding: EdgeInsets.all(6),
                                child: Divider(color: AppColors.grey),
                              ),
                              cart.isProductDiscount && cart.cupomView != null
                                  ? Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.grey3),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "Com o cupom aplicado, os descontos que os produtos já possuem serão substituidos pelo desconto do cupom aplicado ao pedido",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.clip),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: cart.items.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext itemBuilder, index) {
                                  ShoppingCart shoppingCart = cart.items[index];
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(
                                              base64Decode(shoppingCart
                                                  .product
                                                  .productFileView
                                                  .photoBase64ToString),
                                            )),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: tCardBgColor,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                shoppingCart.product.name,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        245, 0, 0, 0),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.clip),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    shoppingCart.product
                                                                .existPercentage &&
                                                            cart.cupomView ==
                                                                null
                                                        ? Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8),
                                                                child: Text(
                                                                  UtilBrasilFields.obterReal(
                                                                      (shoppingCart
                                                                          .product
                                                                          .value -
                                                                          shoppingCart
                                                                              .product
                                                                              .discountValue) * shoppingCart.quantity,
                                                                      moeda:
                                                                          true,
                                                                      decimal:
                                                                          2),
                                                                  style: const TextStyle(
                                                                      color:
                                                                          tGreebBgColor,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                child:
                                                                    Container(
                                                                  height: 22,
                                                                  width: 38,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      color:
                                                                          tGreebBgColor),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '-${NumberFormat.percentPattern("ar").format(shoppingCart.product.percentageValue)}',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        : Container(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8, top: 5),
                                                      child: Text(
                                                        UtilBrasilFields
                                                            .obterReal(
                                                                shoppingCart
                                                                    .amount,
                                                                moeda: true,
                                                                decimal: 2),
                                                        style: TextStyle(
                                                            decoration: shoppingCart
                                                                        .product
                                                                        .existPercentage &&
                                                                    cart.cupomView ==
                                                                        null
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration
                                                                    .none,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2, bottom: 2),
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x32989191),
                                                          offset:
                                                              Offset(0.4, 0.4),
                                                          blurRadius: 1.4,
                                                          spreadRadius: 1.4,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          onPressed: () {
                                                            cart.removeItem(
                                                                shoppingCart
                                                                    .product);
                                                          },
                                                          child: Icon(
                                                            shoppingCart.quantity ==
                                                                    1
                                                                ? Icons
                                                                    .delete_forever_sharp
                                                                : Icons.remove,
                                                            color: shoppingCart
                                                                        .quantity >=
                                                                    1
                                                                ? Colors.red
                                                                : Colors.grey,
                                                            size: 16,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  top: 7),
                                                          child: Text(cart
                                                              .getQuantityByItem(
                                                                  shoppingCart
                                                                      .product)
                                                              .toString()),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2,
                                                                  right: 2),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              cart.add(
                                                                  shoppingCart);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: shoppingCart
                                                                          .quantity >
                                                                      0
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
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
                          ? StreamBuilder<Object>(
                            stream: _blocBudget.stream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.berimbau,
                                      side: BorderSide.none),
                                  onPressed: () {
                                    if (addressView == null){
                                        alertToast(
                                            context,
                                            "Cadastre um endereço para continuar",
                                            3,
                                            Colors.grey,
                                            false);
                                    } else{
                                      _createNewOrder(cart.items, cart.cupomView);
                                      cart.removeAll();
                                    }
                                  },
                                  child: const Text("Continuar"),
                                );
                            }
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
          ),
        );
      },
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

  _getFreightCost() async {
    ApiResponse<double> response = await _blocParameterization.getFreightCost();

    if (response.ok) {
      setState(() {
        freightCost = response.result;
      });
    }
  }

  _getAddressMain() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<AddressView> response = await _blocProfile.getAddressByMain();

    if (response.ok) {
      setState(() {
        addressView = response.result;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  _getCupomByUserAndCupomStatusEnum() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentCupom> response =
        await _blocProfile.getCupomByUserAndCupomStatusEnum();

    if (response.ok) {
      setState(() {
        contentCupom = response.result;
        isLoading = false;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }

  _createNewOrder(
      List<ShoppingCart> shoppingCartList, CupomView? cupomView) async {
    setState(() {
      isLoadingBudget = true;
    });

    BudgetBodySend budgetBodySend =
        BudgetService.createOrderForSend(shoppingCartList, cupomView);

    ApiResponse<Object> response =
        await _blocBudget.createNewOrder(budgetBodySend);

    if (response.ok) {
      Get.offAll(() => const BudgetListView());
    } else {
      alertToast(context, response.erros[0].toString(), 8, Colors.grey, false);
    }
  }
}
