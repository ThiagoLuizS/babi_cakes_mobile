import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/category/category_file_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class CategoryView {

  late int id;
  late CategoryFileView? categoryFileView;
  late String name;
  late String? description;
  late bool show = true; //transient


  CategoryView({
    required this.id,
    this.categoryFileView,
    required this.name,
    this.description,
    required this.show
  });

  CategoryView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryFileView = CategoryFileView.fromJson(json['categoryFileView']);
    name = json['name'];
    description = json['description'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryFileView'] = categoryFileView;
    data['name'] = name;
    data['description'] = description;
    data['show'] = show;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("CategoryView.prefs", json);
  }

  static Future<CategoryView?> get() async {
    String json = await Prefs.getString("CategoryView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    CategoryView categoryView = CategoryView.fromJson(map);

    return categoryView;
  }

  static void clear() {
    Prefs.setString("CategoryView.prefs", "");
  }

}