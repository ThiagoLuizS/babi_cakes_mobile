import 'package:babi_cakes_mobile/src/features/core/models/paypal/paypal_item.dart';
import 'dart:convert' as convert;

class PayPalItemList {
  late List<PayPalItem> items;

  PayPalItemList(this.items);

  PayPalItemList.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    items = convert.json.decode(map)['items'].map<PayPalItem>((data) =>  PayPalItem.fromJson(data)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = items;
    return data;
  }
}