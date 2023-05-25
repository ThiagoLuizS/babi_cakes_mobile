import 'package:babi_cakes_mobile/src/features/core/models/banner/banner_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/content_budget.dart';

import '../../models/budget/budget_view.dart';
import '../../models/parameterization/parameterization_view.dart';

abstract class BannerState {
  List<BannerView> bannerListView = [];
  late bool isLoading = true;
  late String error;
  BannerState({required this.bannerListView, required this.error, required this.isLoading});
}

class BannerInitialState extends BannerState {
  BannerInitialState({required List<BannerView> bannerListView, required String error, required bool isLoading}) : super(bannerListView: bannerListView, error: error, isLoading: isLoading);
}

class BannerSuccessViewState extends BannerState{
  BannerSuccessViewState({required List<BannerView> bannerListView, required String error, required bool isLoading}) : super(bannerListView: bannerListView, error: error, isLoading: isLoading);
}

class BannerErrorState extends BannerState {
  BannerErrorState({required List<BannerView> bannerListView, required String error, required bool isLoading}) : super(bannerListView: bannerListView, error: error, isLoading: isLoading);
}

