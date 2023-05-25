import '../../models/budget/budget_body_send.dart';

abstract class BannerEvent {}

class LoadBannerEvent extends BannerEvent {
  LoadBannerEvent();
}