class PayPalDetails {
  late String subtotal;
  late String shipping;

  PayPalDetails(this.subtotal, this.shipping);

  PayPalDetails.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shipping = json['shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    return data;
  }
}