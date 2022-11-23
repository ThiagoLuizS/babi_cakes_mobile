import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserved_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/property_string.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class BudgetView {
  late int id;
  late int code;
  late DateTime dateCreateBudget;
  late DateTime dateFinalizedBudget;
  late PropertyString budgetStatusEnum;
  late List<BudgetProductReservedView> productReservedViewList = [];

  BudgetView(
      {required this.id,
      required this.code,
      required this.dateCreateBudget,
      required this.dateFinalizedBudget,
      required this.budgetStatusEnum,
      required this.productReservedViewList});

  BudgetView.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    id = json['id'];
    code = json['code'];
    dateCreateBudget = DateTime.parse(json['dateCreateBudget'].toString());
    if(json['dateFinalizedBudget'] != null) {
      dateFinalizedBudget = DateTime.parse(json['dateFinalizedBudget'].toString());
    }
    budgetStatusEnum = PropertyString.fromJson(json['budgetStatusEnum']);
    productReservedViewList = convert.json.decode(map)['productReservedViewList'].map<BudgetProductReservedView>((data) =>  BudgetProductReservedView.fromJson(data)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['dateCreateBudget'] = dateCreateBudget;
    data['dateFinalizedBudget'] = dateFinalizedBudget;
    data['budgetStatusEnum'] = budgetStatusEnum;
    data['productReservedViewList'] = productReservedViewList;
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
