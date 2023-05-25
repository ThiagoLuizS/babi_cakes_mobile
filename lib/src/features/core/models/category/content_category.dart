import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

@JsonSerializable()
class ContentCategory {
  late List<CategoryView>? content = [];
  late int? size;
  late int? totalPages;
  late int? totalElements;
  late int? numberOfElements;

  ContentCategory(
      { this.content,
         this.size,
         this.totalPages,
         this.totalElements,
         this.numberOfElements});

  ContentCategory.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    content = convert.json.decode(map)['content'].map<CategoryView>((data) =>  CategoryView.fromJson(data)).toList();
    size = json['size'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    numberOfElements = json['numberOfElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['size'] = size;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['numberOfElements'] = numberOfElements;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("ContentCategory.prefs", json);
  }

  static Future<ContentCategory?> get() async {
    String json = await Prefs.getString("ContentCategory.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ContentCategory contentCategory = ContentCategory.fromJson(map);

    return contentCategory;
  }
}