import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class CategoryBloc extends SimpleBloc<bool> {
  Future<ApiResponse<ContentCategory>> getAllByPage(int page, int size) async {
    add(true);
    ApiResponse<ContentCategory> response = await CategoryController.getAllByPage(page, size);
    add(false);
    return response;
  }
}