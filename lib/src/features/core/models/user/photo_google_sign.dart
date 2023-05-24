import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class PhotoGoogleSign {
  late String? photo;

  PhotoGoogleSign({required this.photo});

  PhotoGoogleSign.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photo;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("PhotoGoogleSign.prefs", json);
  }

  static Future<PhotoGoogleSign> get() async {
    String json = await Prefs.getString("PhotoGoogleSign.prefs");

    Map<String, dynamic> map = convert.json.decode(json);

    PhotoGoogleSign photoGoogleSign = PhotoGoogleSign.fromJson(map);

    return photoGoogleSign;
  }
}