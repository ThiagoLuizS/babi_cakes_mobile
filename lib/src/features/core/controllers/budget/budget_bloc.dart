import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class BudgetBloc extends SimpleBloc<bool> {
  Future<ApiResponse<ContentBudget>> getBudgetPageByUser(int page, int size) async {
    add(true);
    ApiResponse<ContentBudget> response = await BudgetController.getBudgetPageByUser(page, size);
    add(false);
    return response;
  }
}