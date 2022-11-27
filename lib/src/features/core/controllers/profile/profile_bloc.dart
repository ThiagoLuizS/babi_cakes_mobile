import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/content_address.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class ProfileBloc extends SimpleBloc<bool> {
  Future<ApiResponse<ContentAddress>> getAddressPageByUser() async {
    add(true);
    ApiResponse<ContentAddress> response = await ProfileController.getAddressPageByUser();
    add(false);
    return response;
  }

  Future<ApiResponse<ContentAddress>> updateAddressMain(int id) async {
    add(true);
    ApiResponse<ContentAddress> response = await ProfileController.updateAddressMain(id);
    add(false);
    return response;
  }
}