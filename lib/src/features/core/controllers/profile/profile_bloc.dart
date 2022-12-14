import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_form.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
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

  Future<ApiResponse<bool>> deleteAddress(int id) async {
    add(true);
    ApiResponse<bool> response = await ProfileController.deleteAddress(id);
    add(false);
    return response;
  }

  Future<ApiResponse<AddressForm>> getAddressByCep(String cep) async {
    add(true);
    ApiResponse<AddressForm> response = await ProfileController.getAddressByCep(cep);
    add(false);
    return response;
  }

  Future<ApiResponse<Object>> saveAddress(AddressForm addressForm) async {
    add(true);
    ApiResponse<Object> response = await ProfileController.saveAddress(addressForm);
    add(false);
    return response;
  }

  Future<ApiResponse<ContentCupom>> getCupomByUserAndCupomStatusEnum() async {
    add(true);
    ApiResponse<ContentCupom> response = await ProfileController.getCupomByUserAndCupomStatusEnum();
    add(false);
    return response;
  }

  Future<ApiResponse<AddressView>> getAddressByMain() async {
    add(true);
    ApiResponse<AddressView> response = await ProfileController.getAddressByMain();
    add(false);
    return response;
  }
}