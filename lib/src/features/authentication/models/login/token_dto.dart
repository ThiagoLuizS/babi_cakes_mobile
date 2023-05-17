import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class TokenDTO {
  late String token;
  late String name;
  late String phone;
  late String email;
  late String type;

  TokenDTO(
      {required this.token, required this.name, required this.phone, required this.email, required this.type});

  TokenDTO.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['type'] = type;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("TokenDTO.prefs", json);
  }

  static Future<TokenDTO> get() async {
    String json = await Prefs.getString("TokenDTO.prefs");

    Map<String, dynamic> map = convert.json.decode(json);

    TokenDTO loginForm = TokenDTO.fromJson(map);

    return loginForm;
  }

  static void clear() {
    Prefs.setString("TokenDTO.prefs", "");
  }

}