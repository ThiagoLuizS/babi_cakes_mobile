import '../../models/category/category_view.dart';
import '../../models/category/content_category.dart';
import '../../models/product/content_product.dart';

abstract class ProductState {
  ContentProduct contentProduct = ContentProduct();
  late bool isLoading = true;
  late String error;
  ProductState({required this.contentProduct, required this.isLoading, required this.error});
}

class ProductInitialState extends ProductState {
  ProductInitialState({required ContentProduct contentProduct, required bool isLoading, required String error}) : super(contentProduct: contentProduct, isLoading: isLoading, error: error);
}

class ProductSuccessViewState extends ProductState{
  ProductSuccessViewState({required ContentProduct contentProduct, required bool isLoading, required String error}) : super(contentProduct: contentProduct, isLoading: isLoading, error: error);
}

class ProductErrorState extends ProductState {
  ProductErrorState({required ContentProduct contentProduct, required bool isLoading, required String error}) : super(contentProduct: contentProduct, isLoading: isLoading, error: error);
}

