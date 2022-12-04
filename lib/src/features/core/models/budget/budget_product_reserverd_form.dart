class BudgetProductReservedForm {
  late int productCode;
  late int quantity;

  BudgetProductReservedForm({required this.productCode, required this.quantity});

  BudgetProductReservedForm.fromJson(Map<String, dynamic> json) {
    productCode = json['productCode'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCode'] = productCode;
    data['quantity'] = quantity;
    return data;
  }
}