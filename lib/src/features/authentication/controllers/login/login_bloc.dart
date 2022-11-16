import 'dart:async';

import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_controller.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse<TokenDTO>> login(String email, String password) async {
    add(true);
    ApiResponse<TokenDTO> response = await LoginController.login(email, password);
    add(false);
    return response;
  }
}