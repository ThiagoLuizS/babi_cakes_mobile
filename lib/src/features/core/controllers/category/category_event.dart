import '../../models/budget/budget_body_send.dart';

abstract class CategoryEvent {}

class LoadCategoryPageEvent extends CategoryEvent {
  late int page;
  late int size;

  LoadCategoryPageEvent({required this.page, required this.size});
}

class LoadCategoryFetchEvent extends CategoryEvent {
  LoadCategoryFetchEvent();
}