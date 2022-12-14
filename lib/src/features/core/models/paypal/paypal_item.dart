class PayPalItem {
  late String name;
  late int quantity;
  late String price;
  late String currency;

  PayPalItem(this.name, this.quantity, this.price, this.currency);

  PayPalItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['currency'] = currency;
    return data;
  }
}