import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserved_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/property_string.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class BudgetView {
  late int? id;
  late AddressView? address;
  late CupomView? cupom;
  late UserView? user;
  late int? code;
  late DateTime? dateCreateBudget;
  late DateTime? dateFinalizedBudget;
  late PropertyString? budgetStatusEnum;
  late List<BudgetProductReservedView>? productReservedViewList = [];
  late double? subTotal;
  late double? amount;
  late double? freightCost;

  BudgetView(
      { this.id,
       this.address,
         this.cupom,
       this.code,
       this.dateCreateBudget,
       this.dateFinalizedBudget,
       this.budgetStatusEnum,
       this.productReservedViewList, this.freightCost});

  BudgetView.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    id = json['id'];
    address = AddressView.fromJson(json['address']);
    if(json['cupom'] != null) {

    }
    cupom = json['cupom'] != null ? CupomView.fromJson(json['cupom']) : json['cupom'];
    user = UserView.fromJson(json['user']);
    code = json['code'];
    dateCreateBudget = DateTime.parse(json['dateCreateBudget'].toString());
    if(json['dateFinalizedBudget'] != null) {
      dateFinalizedBudget = DateTime.parse(json['dateFinalizedBudget'].toString());
    }

    budgetStatusEnum = PropertyString.fromJson(json['budgetStatusEnum']);
    if(json['productReservedViewList'] != null) {
      productReservedViewList = convert.json.decode(map)['productReservedViewList'].map<BudgetProductReservedView>((data) =>  BudgetProductReservedView.fromJson(data)).toList();
    }
    subTotal = json['subTotal'];
    amount = json['amount'];
    freightCost = json['freightCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['cupom'] = cupom;
    data['user'] = user;
    data['code'] = code;
    data['dateCreateBudget'] = dateCreateBudget;
    data['dateFinalizedBudget'] = dateFinalizedBudget;
    data['budgetStatusEnum'] = budgetStatusEnum;
    data['productReservedViewList'] = productReservedViewList;
    data['subTotal'] = subTotal;
    data['amount'] = amount;
    data['freightCost'] = freightCost;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("BudgetView.prefs", json);
  }

  static Future<BudgetView?> get() async {
    String json = await Prefs.getString("BudgetView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    BudgetView view = BudgetView.fromJson(map);

    return view;
  }

  static void clear() {
    Prefs.setString("BudgetView.prefs", "");
  }
}
