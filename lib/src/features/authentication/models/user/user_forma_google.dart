import 'package:intl/intl.dart';

class UserFormGoogle {
  late String name;
  late String email;
  late String password;

  UserFormGoogle(this.name, this.email, this.password);

  UserFormGoogle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

}