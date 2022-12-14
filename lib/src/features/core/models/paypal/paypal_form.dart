import 'package:babi_cakes_mobile/src/features/core/models/paypal/paypal_amount.dart';
import 'package:babi_cakes_mobile/src/features/core/models/paypal/paypal_item_list.dart';
import 'dart:convert' as convert;

class PayPalForm {
  late PayPalAmount amount;
  late String description;
  // late PayPalItemList item_list;

  PayPalForm(this.amount, this.description);

  PayPalForm.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
    // if(json['item_list'] != null) {
    //   item_list = PayPalItemList.fromJson(json['item_list']);
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['description'] = description;
    // if(item_list != null) {
    //   data['item_list'] = item_list;
    // }

    return data;
  }

}