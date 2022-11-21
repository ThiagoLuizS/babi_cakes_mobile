import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

@JsonSerializable()
class ContentProduct {
  late List<ProductView> content = [];
  late int? size;
  late int? totalPages;
  late int? totalElements;
  late int? numberOfElements;
  late bool? empty;

  ContentProduct(
      { required this.content,
         this.size,
         this.totalPages,
         this.totalElements,
         this.numberOfElements,
        this.empty});

  ContentProduct.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    content = convert.json.decode(map)['content'].map<ProductView>((data) =>  ProductView.fromJson(data)).toList();
    size = json['size'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['size'] = size;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['numberOfElements'] = numberOfElements;
    data['empty'] = empty;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("ContentProduct.prefs", json);
  }

  static Future<ContentProduct?> get() async {
    String json = await Prefs.getString("ContentProduct.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ContentProduct contentProduct = ContentProduct.fromJson(map);

    return contentProduct;
  }

  static void clear() {
    Prefs.setString("ContentProduct.prefs", "");
  }
}