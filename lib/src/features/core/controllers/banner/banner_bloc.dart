import 'package:babi_cakes_mobile/src/features/core/controllers/banner/banner_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class BannerBloc extends SimpleBloc<bool> {
  Future<ApiResponse<List<BannerView>>> getAll() async {
    add(true);
    ApiResponse<List<BannerView>> response = await BannerController.getAll();
    add(false);
    return response;
  }
}