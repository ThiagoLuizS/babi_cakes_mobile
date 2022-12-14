import 'package:babi_cakes_mobile/src/features/core/controllers/charge/charge_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/models/charge/charge.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class ChargeBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Charge>> createImmediateCharge(int budgetId) async {
    add(true);
    ApiResponse<Charge> response = await ChargeController.createImmediateCharge(budgetId);
    add(false);
    return response;
  }
}