import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class AddressView {
  late int id;
  late int cep;
  late bool addressMain;
  late String addressType;
  late String addressName;
  late String state;
  late String district;
  late String lat;
  late String lng;
  late String city;
  late String cityIbge;
  late String ddd;
  late String number;
  late String complement;

  AddressView(this.id);

  AddressView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cep = json['cep'];
    addressMain = json['addressMain'];
    addressType = json['addressType'] ?? '';
    addressName = json['addressName'] ?? '';
    state = json['state'] ?? '';
    district = json['district'] ?? '';
    lat = json['lat'] ?? '';
    lng = json['lng'] ?? '';
    city = json['city'] ?? '';
    cityIbge = json['cityIbge'] ?? '';
    ddd = json['ddd'];
    number = json['number'] ?? '';
    complement = json['complement'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cep'] = cep;
    data['addressMain'] = addressMain;
    data['addressType'] = addressType;
    data['addressName'] = addressName;
    data['state'] = state;
    data['district'] = district;
    data['lat'] = lat;
    data['lng'] = lng;
    data['city'] = city;
    data['cityIbge'] = cityIbge;
    data['ddd'] = ddd;
    data['number'] = number;
    data['complement'] = complement;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("AddressView.prefs", json);
  }

  static Future<AddressView> get() async {
    String json = await Prefs.getString("AddressView.prefs");

    Map<String, dynamic> map = convert.json.decode(json);

    AddressView addressView = AddressView.fromJson(map);

    return addressView;
  }

  static void clear() {
    Prefs.setString("AddressView.prefs", "");
  }
}