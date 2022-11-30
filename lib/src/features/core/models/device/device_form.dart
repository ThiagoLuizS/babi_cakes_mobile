import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class DeviceForm {
  late String brand;
  late String model;
  late String token;


  DeviceForm(this.brand, this.model, this.token);

  DeviceForm.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    model = json['model'];
    token = json['token'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['model'] = model;
    data['token'] = token;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("DeviceForm.prefs", json);
  }

  static Future<DeviceForm?> get() async {
    String json = await Prefs.getString("DeviceForm.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    DeviceForm deviceForm = DeviceForm.fromJson(map);

    return deviceForm;
  }

  static void clear() {
    Prefs.setString("DeviceForm.prefs", "");
  }
}