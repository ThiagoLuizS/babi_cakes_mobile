import '../../models/budget/budget_body_send.dart';

abstract class ProductEvent {}

class LoadProductByCategoryPageEvent extends ProductEvent {
  late int page;
  late int size;
  late int categoryId;
  late String productName;
  late String sort;

  LoadProductByCategoryPageEvent({required this.page, required this.size, required this.categoryId, required this.productName, required this.sort});
}

class LoadProductPageEvent extends ProductEvent {
  late int page;
  late int size;
  late String productName;
  late String sort;

  LoadProductPageEvent({required this.page, required this.size, required this.productName, required this.sort});
}