import 'package:babi_cakes_mobile/src/features/core/models/paypal/paypal_details.dart';

class PayPalAmount {
  late String total;
  late String currency;
  // late PayPalDetails details;

  PayPalAmount(this.total, this.currency);

  PayPalAmount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currency = json['currency'];
    // if(json['details'] != null) {
    //   details = PayPalDetails.fromJson(json['details']);
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['currency'] = currency;
    // if(details != null) {
    //   data['details'] = details;
    // }

    return data;
  }
}