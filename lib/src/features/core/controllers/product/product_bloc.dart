import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class ProductBloc extends SimpleBloc<bool> {
  Future<ApiResponse<ContentProduct>> getAllByCategoryPage(int page, int size, int categoryId, String productName, String sort) async {
    add(true);
    ApiResponse<ContentProduct> response = await ProductController.getAllByCategoryPage(page, size, categoryId, productName, sort);
    add(false);
    return response;
  }

  Future<ApiResponse<ContentProduct>> getAllByPage(int page, int size, String productName, String sort) async {
    add(true);
    ApiResponse<ContentProduct> response = await ProductController.getAllByPage(page, size, productName, sort);
    add(false);
    return response;
  }
}