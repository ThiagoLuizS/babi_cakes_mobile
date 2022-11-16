import 'dart:convert' as convert;

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ErrorView {
  late int status;
  late String error;
  late List<String> messages;

  ErrorView({required this.status, required this.error, required this.messages});

  ErrorView.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    messages = json['messages'] != null ? json['messages'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['messages'] = messages;
    return data;
  }

}