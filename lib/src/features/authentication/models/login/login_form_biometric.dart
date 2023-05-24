import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class LoginFormBiometric {
  late String? email;
  late String? password;

  LoginFormBiometric({this.email, this.password});

  LoginFormBiometric.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("LoginFormBiometric.prefs", json);
  }

  static Future<LoginFormBiometric?> get() async {
    String json = await Prefs.getString("LoginFormBiometric.prefs");

    if(json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    LoginFormBiometric loginForm = LoginFormBiometric.fromJson(map);

    return loginForm;
  }

  static void clear() {
    Prefs.setString("LoginFormBiometric.prefs", "");
  }

  @override
  String toString() {
    return super.toString();
  }
}