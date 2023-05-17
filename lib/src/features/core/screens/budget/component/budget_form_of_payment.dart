import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/component/budget_details_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../models/budget/optiona_payment.dart';
import 'budget_forget_form_payment.dart';

class BudgetFormOfPayment {
  static Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, BudgetView budgetView) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tSelectFormPayment,
                style: Theme.of(context).textTheme.headlineMedium),
            Text(tSelectFormPaymentDescription,
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 30.0),
            // BudgetForgetFormPayment(
            //   onTap: () => Get.offAll(() => BudgetDetailsComponent(
            //         budgetView: budgetView,
            //         optionalPayment: OptionalPayment.PAYPAL,
            //       )),
            //   title: tPayPal,
            //   subTitle: tPayPalDescription,
            //   btnImage: tPayPalImage,
            // ),
            // const SizedBox(height: 20.0),
            BudgetForgetFormPayment(
              onTap: () => Get.offAll(() => BudgetDetailsComponent(
                    budgetView: budgetView,
                    optionalPayment: OptionalPayment.PIX,
                  )),
              title: tPix,
              subTitle: tPixDescription,
              btnImage: tPixImage,
            ),
          ],
        ),
      ),
    );
  }
}
