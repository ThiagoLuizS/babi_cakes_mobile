import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_state.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/parameterization/parameterization_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/text_strings.dart';
import '../../service/parameterization/parameterization_service.dart';

class WhatsappButtonComponent extends StatefulWidget {
  final BudgetView budgetView;
  const WhatsappButtonComponent({Key? key, required this.budgetView}) : super(key: key);

  @override
  State<WhatsappButtonComponent> createState() => _WhatsappButtonComponentState();
}

class _WhatsappButtonComponentState extends State<WhatsappButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParameterizationBloc, ParameterizationState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
                onPressed: () {
                  ParameterizationService.launchWhatsAppUri(context, state.parameterizationView, "Olá gostaria de mais informações sobre o meu pedido N° ${widget.budgetView.code}");
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.milkCream,
                  side: const BorderSide(width: 0, color: Colors.white),
                ),
                child: const Text(
                  "Fale com o vendedor",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        );
      }
    );
  }


}
