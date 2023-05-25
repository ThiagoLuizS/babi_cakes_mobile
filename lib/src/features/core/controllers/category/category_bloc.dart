import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:bloc/bloc.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryBloc() : super(CategoryInitialState(contentCategory: ContentCategory(), categoryListView: [], isLoading: true, error: '')) {

    on<LoadCategoryPageEvent>((event, emit) => eventLoadPage(event, emit));

    on<LoadCategoryFetchEvent>((event, emit) => eventLoadFetch(event, emit));

  }

  eventLoadPage(LoadCategoryPageEvent event, Emitter emitter) async {
    ApiResponse<ContentCategory> contentCategory = await CategoryController.getAllByPage(event.size, event.page);
    if(contentCategory.ok) {
      emitter(CategorySuccessViewState(contentCategory: contentCategory.result, categoryListView: [], isLoading: false, error: ''));
    } else {
      emitter(CategoryErrorState(contentCategory: ContentCategory(), categoryListView: [], isLoading: false, error: contentCategory.erros[0]));
    }
  }

  eventLoadFetch(LoadCategoryFetchEvent event, Emitter emitter) async {
    ApiResponse<List<CategoryView>> categoryListView = await CategoryController.getAllCategoryAndFetchProduct();
    if(categoryListView.ok) {
      emitter(CategorySuccessViewState(contentCategory: ContentCategory(), categoryListView: categoryListView.result, isLoading: false, error: ''));
    } else {
      emitter(CategoryErrorState(contentCategory: ContentCategory(), categoryListView: [], isLoading: false, error: categoryListView.erros[0]));
    }
  }

}