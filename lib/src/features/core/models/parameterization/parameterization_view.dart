import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';
import 'dart:convert' as convert;

class ParameterizationView {

  late int? id;
  late double? freightCost = 0.0;
  late bool? openShop = false;

  ParameterizationView();

  ParameterizationView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    freightCost = json['freightCost'];
    openShop = json['openShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['freightCost'] = freightCost;
    data['openShop'] = openShop;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("ParameterizationView.prefs", json);
  }

  static Future<ParameterizationView?> get() async {
    String json = await Prefs.getString("ParameterizationView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ParameterizationView view = ParameterizationView.fromJson(map);

    return view;
  }
}