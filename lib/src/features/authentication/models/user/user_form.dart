import 'package:intl/intl.dart';

class UserForm {
  late String name;
  late String email;
  late String birthday;
  late String phone;
  late String password;


  UserForm(this.name, this.email, this.birthday, this.phone, this.password);

  UserForm.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    birthday = json['birthday'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }

}