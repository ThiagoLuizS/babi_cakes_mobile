import 'dart:async';

import 'package:babi_cakes_mobile/src/features/authentication/controllers/user/user_controller.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_forma_google.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class UserBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Object>> saveUser(UserForm userForm) async {
    add(true);
    ApiResponse<Object> response = await UserController.saveUser(userForm);
    add(false);
    return response;
  }

  Future<ApiResponse<Object>> saveUserGoogle(UserFormGoogle userForm) async {
    add(true);
    ApiResponse<Object> response = await UserController.saveUserGoogle(userForm);
    add(false);
    return response;
  }

  Future<ApiResponse<UserView>> getUser() async {
    add(true);
    ApiResponse<UserView> response = await UserController.getUser();
    add(false);
    return response;
  }

  Future<ApiResponse<UserView>> updateUser(UserForm userForm) async {
    add(true);
    ApiResponse<UserView> response = await UserController.updateUser(userForm);
    add(false);
    return response;
  }
}