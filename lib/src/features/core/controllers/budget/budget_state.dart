import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';

import '../../models/budget/budget_view.dart';

abstract class BudgetState {
  ContentBudget contentBudget = ContentBudget(content: []);
  late BudgetView budgetView;
  late String error;
  late bool isLoading = true;
  BudgetState({required this.contentBudget, required this.budgetView, required this.error, required this.isLoading});
}

class BudgetInitialState extends BudgetState {
  BudgetInitialState({required ContentBudget contentBudget, required BudgetView budgetView, required String error, required bool isLoading}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error, isLoading: isLoading);
}

class BudgetSuccessState extends BudgetState {
  BudgetSuccessState({required ContentBudget contentBudget, required BudgetView budgetView, required String error, required bool isLoading}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error, isLoading: isLoading);
}

class BudgetSuccessViewState extends BudgetState{
  BudgetSuccessViewState({required ContentBudget contentBudget, required BudgetView budgetView, required String error, required bool isLoading}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error, isLoading: isLoading);
}

class BudgetErrorState extends BudgetState {
  BudgetErrorState({required ContentBudget contentBudget, required BudgetView budgetView, required String error, required bool isLoading}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error, isLoading: isLoading);
}

