import '../../models/category/category_view.dart';
import '../../models/category/content_category.dart';

abstract class CategoryState {
  ContentCategory contentCategory = ContentCategory();
  List<CategoryView> categoryListView = [];
  late bool isLoading = true;
  late String error;
  CategoryState({required this.contentCategory, required this.categoryListView, required this.isLoading, required this.error});
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState({required ContentCategory contentCategory, required List<CategoryView> categoryListView, required bool isLoading, required String error}) : super(contentCategory: contentCategory, categoryListView: categoryListView, isLoading: isLoading, error: error);
}

class CategorySuccessViewState extends CategoryState{
  CategorySuccessViewState({required ContentCategory contentCategory, required List<CategoryView> categoryListView, required bool isLoading, required String error}) : super(contentCategory: contentCategory, categoryListView: categoryListView, isLoading: isLoading, error: error);
}

class CategoryErrorState extends CategoryState {
  CategoryErrorState({required ContentCategory contentCategory, required List<CategoryView> categoryListView, required bool isLoading, required String error}) : super(contentCategory: contentCategory, categoryListView: categoryListView, isLoading: isLoading, error: error);
}

