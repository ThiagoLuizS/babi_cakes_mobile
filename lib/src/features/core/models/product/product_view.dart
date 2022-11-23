import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_file_view.dart';

import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class ProductView {
  late int id;
  late CategoryView categoryView;
  late ProductFileView productFileView;
  late int code;
  late String name;
  late String description;
  late double value;
  late double discountValue;
  late num percentageValue;
  late int minimumOrder;
  late bool existPercentage;
  late String tag;

  ProductView({
    required this.id,
    required this.categoryView,
    required this.productFileView,
    required this.code,
    required this.name,
    required this.description,
    required this.value,
    required this.discountValue,
    required this.percentageValue,
    required this.minimumOrder,
    required this.existPercentage,
    required this.tag,
  });

  ProductView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryView = CategoryView.fromJson(json['categoryView']);
    productFileView = ProductFileView.fromJson(json['productFileView']);
    code = json['code'];
    name = json['name'];
    description = json['description'];
    value = json['value'];
    discountValue = json['discountValue'];
    percentageValue = json['percentageValue'];
    minimumOrder = json['minimumOrder'];
    existPercentage = json['existPercentage'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryView'] = categoryView;
    data['productFileView'] = productFileView;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['value'] = value;
    data['discountValue'] = discountValue;
    data['percentageValue'] = percentageValue;
    data['percentageValue'] = percentageValue;
    data['minimumOrder'] = minimumOrder;
    data['existPercentage'] = existPercentage;
    data['tag'] = tag;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("ProductView.prefs", json);
  }

  static Future<ProductView?> get() async {
    String json = await Prefs.getString("ProductView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ProductView productView = ProductView.fromJson(map);

    return productView;
  }

  static void clear() {
    Prefs.setString("ProductView.prefs", "");
  }

}