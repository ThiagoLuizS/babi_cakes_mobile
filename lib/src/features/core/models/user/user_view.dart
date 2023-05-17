import 'package:get/get.dart';

class UserView {
  late int id;
  late String name;
  late String email;
  late DateTime birthday;
  late String phone;

  UserView();

  UserView.fromJson(Map<String, dynamic> json) {
    if(json['id'] != null) {
      id = json['id'];
    }
    name = json['name'];
    email = json['email'];

    if(json['birthday'] != null) {
      birthday = DateTime.parse(json['birthday'].toString());
    } else {
      birthday = json['birthday'];
    }
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['birthday'] = birthday;
    data['phone'] = phone;
    return data;
  }
}