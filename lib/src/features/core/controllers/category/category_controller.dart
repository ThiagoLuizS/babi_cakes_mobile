import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';

class CategoryController {
  static Future<ApiResponse<ContentCategory>> getAllByPage(int page,
      int size) async {
    try {
      Uri uri = Uri.http(
          Config.apiURL, '/api/categories/pageable', {'page': '0'});

      TokenDTO? token = await TokenDTO.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token!.token}"
      };

      String encode = json.encode(headers);

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final category = ContentCategory.fromJson(mapResponse);

        return ApiResponse.ok(category);
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