import 'package:babi_cakes_mobile/src/features/core/models/property_string.dart';

class CupomView {
  late int id;
  late String code;
  late String description;
  late DateTime dateCreated;
  late DateTime dateExpired;
  late PropertyString cupomStatusEnum;
  late double cupomValue;
  late bool cupomIsValueMin;
  late double cupomValueMin;

  CupomView(this.id, this.code, this.description, this.dateCreated,
      this.dateExpired, this.cupomStatusEnum, this.cupomValue,
      this.cupomIsValueMin, this.cupomValueMin);

  CupomView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    dateCreated = DateTime.parse(json['dateCreated'].toString());
    dateExpired = DateTime.parse(json['dateExpired'].toString());
    cupomStatusEnum = PropertyString.fromJson(json['cupomStatusEnum']);
    cupomValue = json['cupomValue'] ?? '';
    cupomIsValueMin = json['cupomIsValueMin'] ?? '';
    cupomValueMin = json['cupomValueMin'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['dateCreated'] = dateCreated;
    data['dateExpired'] = dateExpired;
    data['cupomStatusEnum'] = cupomStatusEnum;
    data['cupomValue'] = cupomValue;
    data['cupomIsValueMin'] = cupomIsValueMin;
    data['cupomValueMin'] = cupomValueMin;
    return data;
  }
}