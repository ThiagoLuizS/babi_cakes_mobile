import 'dart:async';
import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_event.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_state.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../controllers/budget/budget_bloc_state.dart';
import 'components/address_shopping_cart.dart';
import 'components/body_cupom_and_product_shopping_cart.dart';
import 'components/bottom_navigator_shopping_cart.dart';
import 'components/header_shopping_cart.dart';
import 'components/product_list_shopping_cart.dart';

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
  final ProfileBloc _blocProfile = ProfileBloc();
  AddressView? addressView;
  late bool isLoading = true;
  late bool isLoadingBudget = true;

  late final BudgetBlocState budgetBlocState;

  @override
  void dispose() {
    budgetBlocState.close();
    _blocBudget.dispose();
    _blocProfile.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    budgetBlocState = BudgetBlocState();

    isLoading = true;
    _getAddressMain();
    _getCupomByUserAndCupomStatusEnum();

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
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      HeaderShoppingCart(width: width),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AddressShoppingCart(isLoading: isLoading, addressView: addressView),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: BodyCupomAndProductShoppingCart(contentCupom: contentCupom),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigatorShoppingCart(addressView: addressView,),
        );
      },
    );
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

}








