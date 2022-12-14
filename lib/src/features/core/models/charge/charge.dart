import 'package:babi_cakes_mobile/src/features/core/models/property_string.dart';
import 'dart:convert' as convert;

class Charge {
  late int id;
  late int expiration;
  late DateTime created;
  late String taxID;
  late String correlationID;
  late String transactionID;
  late String brCode;

  Charge(this.id, this.expiration, this.created, this.taxID,
      this.correlationID, this.transactionID, this.brCode);

  Charge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expiration = json['expiration'];
    created = DateTime.parse(json['created'].toString());
    taxID = json['taxID'];
    correlationID = json['correlationID'];
    transactionID = json['transactionID'];
    brCode = json['brCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['expiration'] = expiration;
    data['created'] = created;
    data['taxID'] = taxID;
    data['correlationID'] = correlationID;
    data['transactionID'] = transactionID;
    data['brCode'] = brCode;
    return data;
  }
}