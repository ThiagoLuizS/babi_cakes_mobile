import 'dart:async';

import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_event.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';
import 'package:bloc/bloc.dart';

import '../../../../utils/general/api_response.dart';
import 'budget_controller.dart';
import 'budget_state.dart';

class BudgetBlocState extends Bloc<BudgetEvent, BudgetState> {

  BudgetBlocState() : super(BudgetInitialState(contentBudget: ContentBudget(content: []), budgetView: BudgetView(), error: '')) {

    on<LoadBudgetEvent>((event, emit) => eventLoad(event, emit));

    on<LoadBudgetIdEvent>((event, emit) => eventLoadId(event, emit));

    on<CreateNewOrder>((event, emit) => eventCreate(event, emit));

  }

  eventLoad(LoadBudgetEvent event, Emitter emitter) async {
    ApiResponse<ContentBudget> contentBudget = await BudgetController.getBudgetPageByUser(event.size, event.page);
    if(contentBudget.ok) {
      emitter(BudgetSuccessState(contentBudget: contentBudget.result, budgetView: BudgetView(), error: ''));
    } else {
      emitter(BudgetErrorState(error: contentBudget.erros[0], contentBudget: ContentBudget(content: []), budgetView: BudgetView()));
    }
  }

  eventLoadId(LoadBudgetIdEvent event, Emitter emitter) async {
    ApiResponse<BudgetView> budgetView = await BudgetController.getBudgetByUserAndById(event.id);
    if(budgetView.ok) {
      emitter(BudgetSuccessViewState(budgetView: budgetView.result, contentBudget: ContentBudget(content: []), error: ''));
    } else {
      emitter(BudgetErrorState(error: budgetView.erros[0], contentBudget: ContentBudget(content: []), budgetView: BudgetView()));
    }
  }


  eventCreate(CreateNewOrder event, Emitter emitter) async {
    ApiResponse<BudgetView> budgetView = await BudgetController.createNewOrder(event.budgetBodySend);
    if(budgetView.ok) {
      emitter(BudgetSuccessViewState(budgetView: budgetView.result, contentBudget: ContentBudget(content: []), error: '' ));
    } else {
      emitter(BudgetErrorState(error: budgetView.erros[0], contentBudget: ContentBudget(content: []), budgetView: BudgetView()));
    }
  }
}