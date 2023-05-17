import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_forma_google.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';
import 'package:http/http.dart' as http;



class UserController {
  static Future<ApiResponse<Object>> saveUser(UserForm userForm) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/users');

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      var response = await http.post(uri, body: json.encode(userForm), headers: headers);

      if (response.statusCode == 201) {
        return ApiResponse.okNotResult();
      } else {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        ErrorView error = ErrorView.fromJson(mapResponse);
        return ApiResponse.errors(error.messages);
      }
    } on TimeoutException catch (e) {
      return ApiResponse.errors([msgTimeOutGlobal]);
    } on SocketException catch (e) {
      return ApiResponse.errors([msgNotConnectionGlobal]);
    } catch (e) {
      return ApiResponse.errors([msgGlobalError]);
    }
  }

  static Future<ApiResponse<Object>> saveUserGoogle(UserFormGoogle userForm) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/users/google');

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      var response = await http.post(uri, body: json.encode(userForm), headers: headers);

      if (response.statusCode == 201) {
        return ApiResponse.okNotResult();
      } else {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        ErrorView error = ErrorView.fromJson(mapResponse);
        return ApiResponse.errors(error.messages);
      }
    } on TimeoutException catch (e) {
      return ApiResponse.errors([msgTimeOutGlobal]);
    } on SocketException catch (e) {
      return ApiResponse.errors([msgNotConnectionGlobal]);
    } catch (e) {
      return ApiResponse.errors([msgGlobalError]);
    }
  }

  static Future<ApiResponse<UserView>> updateUser(UserForm userForm) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/users');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };
      var response = await http.put(uri, body: json.encode(userForm), headers: headers);

      if (response.statusCode == 201) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final userView = UserView.fromJson(mapResponse);

        return ApiResponse.ok(userView);
      } else {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        ErrorView error = ErrorView.fromJson(mapResponse);
        return ApiResponse.errors(error.messages);
      }
    } on TimeoutException catch (e) {
      return ApiResponse.errors([msgTimeOutGlobal]);
    } on SocketException catch (e) {
      return ApiResponse.errors([msgNotConnectionGlobal]);
    } catch (e) {
      return ApiResponse.errors([msgGlobalError]);
    }
  }

  static Future<ApiResponse<UserView>> getUser() async {
    try {

      TokenDTO token = await TokenDTO.get();

      Uri uri = Uri.http(Config.apiURL, '/api/users/email/${token.email}');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final userView = UserView.fromJson(mapResponse);

        return ApiResponse.ok(userView);
      } else {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        ErrorView error = ErrorView.fromJson(mapResponse);
        return ApiResponse.errors(error.messages);
      }
    } on TimeoutException catch (e) {
      return ApiResponse.errors([msgTimeOutGlobal]);
    } on SocketException catch (e) {
      return ApiResponse.errors([msgNotConnectionGlobal]);
    } catch (e) {
      return ApiResponse.errors([msgGlobalError]);
    }
  }
}