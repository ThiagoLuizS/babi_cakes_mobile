import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_file_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class BannerView {

  late int id;
  late ProductView? product;
  late CategoryView? category;
  late BannerFileView? file;
  late String title;


  BannerView({
    required this.id,
    this.product,
    this.file,
    required this.title,
  });

  BannerView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['product'] != null) {
      product = ProductView.fromJson(json['product']);
    }
    if(json['category'] != null) {
      category = CategoryView.fromJson(json['category']);
    }
    file = BannerFileView.fromJson(json['file']);
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    data['category'] = category;
    data['file'] = file;
    data['title'] = title;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("BannerView.prefs", json);
  }

  static Future<BannerView?> get() async {
    String json = await Prefs.getString("BannerView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    BannerView view = BannerView.fromJson(map);

    return view;
  }

  static void clear() {
    Prefs.setString("BannerView.prefs", "");
  }

}