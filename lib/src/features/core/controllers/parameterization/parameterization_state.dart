import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';

import '../../models/budget/budget_view.dart';
import '../../models/parameterization/parameterization_view.dart';

abstract class ParameterizationState {
  ParameterizationView parameterizationView = ParameterizationView();
  late bool isLoading = true;
  late String error;
  ParameterizationState({required this.parameterizationView, required this.error, required this.isLoading});
}

class ParameterizationInitialState extends ParameterizationState {
  ParameterizationInitialState({required ParameterizationView parameterizationView, required String error, required bool isLoading}) : super(parameterizationView: parameterizationView, error: error, isLoading: isLoading);
}

class ParameterizationSuccessViewState extends ParameterizationState{
  ParameterizationSuccessViewState({required ParameterizationView parameterizationView, required String error, required bool isLoading}) : super(parameterizationView: parameterizationView, error: error, isLoading: isLoading);
}

class ParameterizationErrorState extends ParameterizationState {
  ParameterizationErrorState({required ParameterizationView parameterizationView, required String error, required bool isLoading}) : super(parameterizationView: parameterizationView, error: error, isLoading: isLoading);
}

