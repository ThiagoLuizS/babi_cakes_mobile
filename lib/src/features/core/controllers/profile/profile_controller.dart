import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_form.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/content_address.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';
import 'package:http/http.dart' as http;

class ProfileController {
  static Future<ApiResponse<ContentAddress>> getAddressPageByUser() async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/address/all');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final contentAddress = ContentAddress.fromJson(mapResponse);

        return ApiResponse.ok(contentAddress);
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

  static Future<ApiResponse<ContentAddress>> updateAddressMain(int id) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/address/main/$id');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.put(uri, headers: headers);

      if (response.statusCode == 200) {
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

  static Future<ApiResponse<AddressForm>> getAddressByCep(String cep) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/address/cep/$cep');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final addressForm = AddressForm.fromJson(mapResponse);

        return ApiResponse.ok(addressForm);
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

  static Future<ApiResponse<Object>> saveAddress(AddressForm addressForm) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/address');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.post(uri, body: json.encode(addressForm), headers: headers);

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

  static Future<ApiResponse<ContentCupom>> getCupomByUserAndCupomStatusEnum() async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/cupons/all', {'status': 'ACTIVE'});

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final contentCupom = ContentCupom.fromJson(mapResponse);

        return ApiResponse.ok(contentCupom);
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