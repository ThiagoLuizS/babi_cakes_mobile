import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';

class ProductController {
  static Future<ApiResponse<ContentProduct>> getAllByCategoryPage(int page,
      int size, int categoryId, String productName, String sort) async {
    try {

      Uri uri = Uri.http(
          Config.apiURL, '/api/products/pageable/category/$categoryId', {'page': page.toString(), 'size': size.toString(), 'productName': productName, 'excluded': 'false', 'sort': sort});

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      String encode = json.encode(headers);

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final product = ContentProduct.fromJson(mapResponse);

        product.save();

        return ApiResponse.ok(product);
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

  static Future<ApiResponse<ContentProduct>> getAllByPage(int page,
      int size, String productName, String sort) async {
    try {

      Uri uri = Uri.http(
          Config.apiURL, '/api/products/pageable/all', {'page': page.toString(), 'size': size.toString(), 'productName': productName, 'excluded': 'false', 'sort': sort});

      TokenDTO? token = await TokenDTO.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      String encode = json.encode(headers);

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final product = ContentProduct.fromJson(mapResponse);

        product.save();

        return ApiResponse.ok(product);
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