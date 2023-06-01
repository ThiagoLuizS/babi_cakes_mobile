import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_strings.dart';
import '../../../../utils/general/alert.dart';
import '../../models/parameterization/parameterization_view.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class ParameterizationService {

  static launchWhatsAppUri(BuildContext context, ParameterizationView parameterizationView, String text) async {
    try {
      if(parameterizationView.linkWhatsapp != null && parameterizationView.linkWhatsapp!.isNotEmpty) {
        var linkWhatsapp = "${parameterizationView.linkWhatsapp}&text=$text";
        if(!await canLaunch(linkWhatsapp)) {
          await launch(linkWhatsapp);
        } else {
          alertToast(context, tMessageWhatsappEnabledError, 8, Colors.grey, false);
        }
      } else {
        alertToast(context, tMessageWhatsappError, 8, Colors.grey, false);
      }
    }catch(e) {
      alertToast(context, tMessageWhatsappError, 8, Colors.grey, false);
    }
  }
}