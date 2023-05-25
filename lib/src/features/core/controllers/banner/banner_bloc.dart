import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_event.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/parameterization/parameterization_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../utils/general/api_response.dart';
import '../../models/banner/banner_view.dart';
import '../../models/parameterization/parameterization_view.dart';
import 'banner_controller.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {

  BannerBloc() : super(BannerInitialState(bannerListView: [], error: '', isLoading: true)) {

    on<LoadBannerEvent>((event, emit) => eventLoad(event, emit));

  }

  eventLoad(LoadBannerEvent event, Emitter emitter) async {
    ApiResponse<List<BannerView>> bannerListView = await BannerController.getAll();
    if(bannerListView.ok) {
      emitter(BannerSuccessViewState(bannerListView: bannerListView.result, error: '', isLoading: false));
    } else {
      emitter(BannerErrorState(bannerListView: [], error: bannerListView.erros[0], isLoading: false, ));
    }
  }

}