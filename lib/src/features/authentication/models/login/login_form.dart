import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class LoginForm {
  late String email;
  late String password;

  LoginForm({required this.email, required this.password});

  LoginForm.fromJson(Map<String, dynamic> json) {
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
    Prefs.setString("LoginForm.prefs", json);
  }

  static Future<LoginForm?> get() async {
    String json = await Prefs.getString("LoginForm.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    LoginForm loginForm = LoginForm.fromJson(map);

    return loginForm;
  }

  static void clear() {
    Prefs.setString("LoginForm.prefs", "");
  }
}