import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_body_send.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/constants.dart';
import 'package:http/http.dart' as http;

class BudgetController {

  static Future<ApiResponse<ContentBudget>> getBudgetPageByUser(int page,
      int size) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/budgets/pageable', {'sort': 'code,desc'});

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final contentBudget = ContentBudget.fromJson(mapResponse);

        //contentBudget.save();

        return ApiResponse.ok(contentBudget);
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

  static Future<ApiResponse<BudgetView>> getBudgetByUserAndById(int budgetId) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/budgets/id/$budgetId');

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        Map<String, dynamic> mapResponse = json.decode(response.body);

        final contentBudget = BudgetView.fromJson(mapResponse);

        return ApiResponse.ok(contentBudget);
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

  static Future<ApiResponse<BudgetView>> createNewOrder(BudgetBodySend budgetBodySend) async {
    try {

      Uri uri = Uri.http(Config.apiURL, '/api/budgets/new-order', {'cupomCode': budgetBodySend.cupomCode});

      TokenDTO token = await TokenDTO.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.token}"
      };

      var response = await http.post(uri, body: json.encode(budgetBodySend.listItems), headers: headers);

      if (response.statusCode == 201) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final contentBudget = BudgetView.fromJson(mapResponse);

        return ApiResponse.ok(contentBudget);
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