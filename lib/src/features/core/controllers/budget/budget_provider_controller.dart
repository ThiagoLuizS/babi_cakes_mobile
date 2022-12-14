import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetProviderController extends ChangeNotifier {

  late bool isDurationCopy = false;

  bool get isDurationMessageCopy => getDurationMessage();

  setMessageClipboardCopy() {
    isDurationCopy = true;
    Future.delayed(const Duration(seconds: 10), () async {
      isDurationCopy = false;
    });
    notifyListeners();
  }

  bool getDurationMessage() {
    return isDurationCopy;
  }

}