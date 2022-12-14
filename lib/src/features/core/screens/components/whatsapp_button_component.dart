import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButtonComponent extends StatefulWidget {
  final BudgetView budgetView;
  const WhatsappButtonComponent({Key? key, required this.budgetView}) : super(key: key);

  @override
  State<WhatsappButtonComponent> createState() => _WhatsappButtonComponentState();
}

class _WhatsappButtonComponentState extends State<WhatsappButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            onPressed: () {
              _launchWhatsAppUri();
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

  _launchWhatsAppUri() async {
    try {
      var linkWhatsapp = "whatsapp://send?phone=+5531994303084&text=Olá gostaria de mais informações sobre meu pedido N° ${widget.budgetView.code}";
      if(!await canLaunch(linkWhatsapp)) {
        await launch(linkWhatsapp);
      } else {
        alertToast(context, "Seu dispositivo não tem o Whatsapp intalado", 8, Colors.grey, false);
      }
    }catch(e) {
      alertToast(context, "Não foi possivel chamar o vendedor", 8, Colors.grey, false);
    }
  }
}
