import '../../models/budget/budget_body_send.dart';

abstract class BudgetEvent {}

class LoadBudgetEvent extends BudgetEvent {
  late int page;
  late int size;

  LoadBudgetEvent({required this.page, required this.size});
}

class LoadBudgetIdEvent extends BudgetEvent {
  late int id;

  LoadBudgetIdEvent({required this.id});
}

class CreateNewOrder extends BudgetEvent {
  late BudgetBodySend budgetBodySend;

  CreateNewOrder({required this.budgetBodySend});
}