import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/src/features/authentication/models/login/login_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/service/device_service.dart';
import 'package:http/http.dart' as http;

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

import 'package:babi_cakes_mobile/src/utils/general/constants.dart';



class LoginController {
  static Future<ApiResponse<TokenDTO>> login(String email, String password) async {
    try {
      Uri uri = Uri.http(Config.apiURL, '/api/auth');

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {'email': email, 'password': password};

      String encode = json.encode(params);

      var response = await http.post(uri, body: encode, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final loginForm = LoginForm(email: email, password: password);

        loginForm.save();

        final user = TokenDTO.fromJson(mapResponse);

        user.save();

        DeviceService.saveDeviceGetInstance();

        return ApiResponse.ok(user);
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