import 'dart:async';

import 'package:babi_cakes_mobile/src/features/authentication/controllers/user/user_controller.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_form.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class UserBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Object>> saveUser(UserForm userForm) async {
    add(true);
    ApiResponse<Object> response = await UserController.saveUser(userForm);
    add(false);
    return response;
  }
}