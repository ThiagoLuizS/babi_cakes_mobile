import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class ProductBloc extends SimpleBloc<bool> {
  Future<ApiResponse<ContentProduct>> getAllByPage(int page, int size, int categoryId, String productName) async {
    add(true);
    ApiResponse<ContentProduct> response = await ProductController.getAllByPage(page, size, categoryId, productName);
    add(false);
    return response;
  }
}