import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_provider_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/charge/charge_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/charge/charge.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/pay_pal_integration.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../models/budget/optiona_payment.dart';

class PaymentButtonComponent extends StatefulWidget {
  final BudgetView budgetView;
  final String value;
  final OptionalPayment optionalPayment;

  const PaymentButtonComponent({Key? key, required this.budgetView, required this.optionalPayment, this.value = ""})
      : super(key: key);

  @override
  State<PaymentButtonComponent> createState() =>
      _PaymentButtonComponentState();
}

class _PaymentButtonComponentState extends State<PaymentButtonComponent> {
  late bool isDurationMessaCopy = false;
  final ChargeBloc _blocCharge = ChargeBloc();
  late Charge charge;
  late bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<BudgetProviderController>(
        builder: (ctx, cart, child) {
          return !isLoading ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  _optionalShowPayment(height);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.milkCream,
                  side: const BorderSide(width: 0, color: Colors.white),
                ),
                child: const Text(
                  "Fazer pedido",
                  style: TextStyle(color: Colors.black),
                )),
          ) : const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  color: AppColors.berimbau),
            ),
          );
        });

  }

  _optionalShowPayment(double height) {
    if(widget.optionalPayment == OptionalPayment.PIX) {
      _createImmediateChargeAndGetPix(height);
    } else {
      PayPalIntegration.getPaypal(context);
    }
  }

  _createImmediateChargeAndGetPix(double height) async {
    if(widget.budgetView.budgetStatusEnum!.type == BudgetService.awaitPayment) {
      setState(() {
        isLoading = true;
      });
      ApiResponse<Charge> response =
      await _blocCharge.createImmediateCharge(widget.budgetView.id!);

      if (response.ok) {
        setState(() {
          charge = response.result;
        });
        PayPalIntegration.getPix(context, height, isDurationMessaCopy, charge);
      } else {
        alertToast(context, response.erros[0].toString(), 8, Colors.grey, false);
      }

      setState(() {
        isLoading = false;
      });
    }

  }
}
