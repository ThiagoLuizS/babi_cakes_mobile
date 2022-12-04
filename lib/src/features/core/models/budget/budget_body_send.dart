import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserverd_form.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';

class BudgetBodySend {
  late List<BudgetProductReservedForm> listItems = [];
  late String cupomCode;

  BudgetBodySend({required this.listItems, required this.cupomCode});

  BudgetBodySend.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    listItems = convert.json.decode(map)['listItems'].map<BudgetProductReservedForm>((data) =>  BudgetProductReservedForm.fromJson(data)).toList();
    cupomCode = json['cupomCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listItems'] = listItems;
    data['cupomCode'] = cupomCode;
    return data;
  }

}