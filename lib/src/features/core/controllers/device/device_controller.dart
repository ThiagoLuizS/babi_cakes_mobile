import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/models/device/device_form.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';
import 'package:http/http.dart' as http;

class DeviceController {
  static Future<ApiResponse<Object>> saveDevice(DeviceForm deviceForm) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/devices');

      TokenDTO? token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.post(uri, body: json.encode(deviceForm), headers: headers);

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
}