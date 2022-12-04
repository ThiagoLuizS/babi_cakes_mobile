import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_controller.dart';
import 'package:babi_cakes_mobile/src/service/simple_bloc.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

class ParameterizationBloc extends SimpleBloc<bool> {
  Future<ApiResponse<double>> getFreightCost() async {
    add(true);
    ApiResponse<double> response = await ParameterizationController.getFreightCost();
    add(false);
    return response;
  }
}