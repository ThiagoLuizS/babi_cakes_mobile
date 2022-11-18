import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class CategoryFileView {
  late int id;
  late String name;
  late String type;
  late String photoBase64ToString;


  CategoryFileView({
    required this.id,
    required this.name,
    required this.type,
    required this.photoBase64ToString
  });

  CategoryFileView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    photoBase64ToString = json['photoBase64ToString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['photoBase64ToString'] = photoBase64ToString;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("CategoryFileView.prefs", json);
  }

  static Future<CategoryFileView?> get() async {
    String json = await Prefs.getString("CategoryFileView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    CategoryFileView categoryView = CategoryFileView.fromJson(map);

    return categoryView;
  }

  static void clear() {
    Prefs.setString("CategoryFileView.prefs", "");
  }
}