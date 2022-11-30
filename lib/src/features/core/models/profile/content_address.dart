import 'dart:convert' as convert;

import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ContentAddress {
  late List<AddressView> content = [];
  late int? size;
  late int? totalPages;
  late int? totalElements;
  late int? numberOfElements;
  late bool? empty;

  ContentAddress(
      { required this.content,
         this.size,
         this.totalPages,
         this.totalElements,
         this.numberOfElements,
        this.empty});

  ContentAddress.fromJson(Map<String, dynamic> json) {
    String map = convert.json.encode(json);
    content = convert.json.decode(map)['content'].map<AddressView>((data) =>  AddressView.fromJson(data)).toList();
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
    Prefs.setString("ContentAddress.prefs", json);
  }

  static Future<ContentAddress?> get() async {
    String json = await Prefs.getString("ContentAddress.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    ContentAddress contentAddress = ContentAddress.fromJson(map);

    return contentAddress;
  }

  static void clear() {
    Prefs.setString("ContentAddress.prefs", "");
  }
}