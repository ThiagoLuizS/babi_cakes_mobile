import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';

import '../../models/budget/budget_view.dart';

abstract class BudgetState {
  ContentBudget contentBudget = ContentBudget(content: []);
  late BudgetView budgetView;
  late String error;
  BudgetState({required this.contentBudget, required this.budgetView, required this.error});
}

class BudgetInitialState extends BudgetState {
  BudgetInitialState({required ContentBudget contentBudget, required BudgetView budgetView, required String error}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error);
}

class BudgetSuccessState extends BudgetState {
  BudgetSuccessState({required ContentBudget contentBudget, required BudgetView budgetView, required String error}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error);
}

class BudgetSuccessViewState extends BudgetState{
  BudgetSuccessViewState({required ContentBudget contentBudget, required BudgetView budgetView, required String error}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error);
}

class BudgetErrorState extends BudgetState {
  BudgetErrorState({required ContentBudget contentBudget, required BudgetView budgetView, required String error}) : super(contentBudget: contentBudget, budgetView: budgetView, error: error);
}

