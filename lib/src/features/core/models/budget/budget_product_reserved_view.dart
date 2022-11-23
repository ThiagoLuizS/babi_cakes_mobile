import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';

class BudgetProductReservedView {
  late int id;
  late ProductView productView;
  late int quantity;

  BudgetProductReservedView(
      {required this.id, required this.productView, required this.quantity});

  BudgetProductReservedView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productView = ProductView.fromJson(json['productView']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productView'] = productView;
    data['quantity'] = quantity;
    return data;
  }
}
