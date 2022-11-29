import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ContentCupom {
  late List<CupomView> content = [];
  late int? size;
  late int? totalPages;
  late int? totalElements;
  late int? numberOfElements;
  late bool? empty;

  ContentCupom(
      { required this.content,
         this.size,
         this.totalPages,
         this.totalElements,
         this.numberOfElements,
        this.empty});

  ContentCupom.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    content = convert.json.decode(map)['content'].map<CupomView>((data) =>  CupomView.fromJson(data)).toList();
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
    Prefs.setString("ContentCupom.prefs", json);
  }

  static Future<ContentCupom?> get() async {
    String json = await Prefs.getString("ContentCupom.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ContentCupom contentCupom = ContentCupom.fromJson(map);

    return contentCupom;
  }

  static void clear() {
    Prefs.setString("ContentCupom.prefs", "");
  }
}