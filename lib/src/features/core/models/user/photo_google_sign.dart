import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class PhotoGoogleSign {
  late String? photo;
  late String? email;

  PhotoGoogleSign({this.photo, this.email});

  PhotoGoogleSign.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photo;
    data['email'] = email;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("PhotoGoogleSign.prefs", json);
  }

  static Future<PhotoGoogleSign> get() async {
    String json = await Prefs.getString("PhotoGoogleSign.prefs");

    if(json.isNotEmpty) {
      Map<String, dynamic> map = convert.json.decode(json);
      PhotoGoogleSign photoGoogleSign = PhotoGoogleSign.fromJson(map);

      return photoGoogleSign;
    }

    return PhotoGoogleSign();
  }

  static void clear() {
    Prefs.setString("PhotoGoogleSign.prefs", "");
  }
}