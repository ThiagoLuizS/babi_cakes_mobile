import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_event.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../utils/general/api_response.dart';
import '../../models/parameterization/parameterization_view.dart';

class ParameterizationBloc extends Bloc<ParameterizationEvent, ParameterizationState> {

  ParameterizationBloc() : super(ParameterizationInitialState(parameterizationView: ParameterizationView(), error: '', isLoading: true)) {

    on<LoadParameterizationEvent>((event, emit) => eventLoad(event, emit));

  }

  eventLoad(LoadParameterizationEvent event, Emitter emitter) async {
    ApiResponse<ParameterizationView> parameterizationView = await ParameterizationController.getParameterizationView();
    if(parameterizationView.ok) {
      emitter(ParameterizationSuccessViewState(parameterizationView: parameterizationView.result, error: '', isLoading: false));
    } else {
      emitter(ParameterizationErrorState(parameterizationView: ParameterizationView(), error: parameterizationView.erros[0], isLoading: false));
    }
  }

}