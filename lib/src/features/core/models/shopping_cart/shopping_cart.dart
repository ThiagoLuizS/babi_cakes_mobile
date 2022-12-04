import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';

import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class ShoppingCart {
  late ProductView product;
  late int quantity;
  late double amount;


  ShoppingCart(this.product, this.quantity, this.amount);

  ShoppingCart.fromJson(Map<String, dynamic> json) {
    product = ProductView.fromJson(json['product']);
    quantity = json['quantity'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['quantity'] = quantity;
    data['amount'] = amount;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("ShoppingCart.prefs", json);
  }

  static Future<ShoppingCart?> get() async {
    String json = await Prefs.getString("ShoppingCart.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ShoppingCart shoppingCart = ShoppingCart.fromJson(map);

    return shoppingCart;
  }

  static void clear() {
    Prefs.setString("ShoppingCart.prefs", "");
  }
}