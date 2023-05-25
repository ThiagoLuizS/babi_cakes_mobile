import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_event.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_state.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:bloc/bloc.dart';

import '../../models/product/content_product.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(ProductInitialState(contentProduct: ContentProduct(), isLoading: true, error: '')) {

    on<LoadProductByCategoryPageEvent>((event, emit) => eventLoadByCategoryPage(event, emit));

    on<LoadProductPageEvent>((event, emit) => eventLoadPage(event, emit));

  }

  eventLoadByCategoryPage(LoadProductByCategoryPageEvent event, Emitter emitter) async {
    ApiResponse<ContentProduct> content = await ProductController.getAllByCategoryPage(event.page, event.size, event.categoryId, event.productName, event.sort);
    if(content.ok) {
      emitter(ProductSuccessViewState(contentProduct: content.result, isLoading: false, error: ''));
    } else {
      emitter(ProductErrorState(contentProduct: ContentProduct(), isLoading: false, error: content.erros[0]));
    }
  }

  eventLoadPage(LoadProductPageEvent event, Emitter emitter) async {
    ApiResponse<ContentProduct> content = await ProductController.getAllByPage(event.page, event.size, event.productName, event.sort);
    if(content.ok) {
      emitter(ProductSuccessViewState(contentProduct: content.result, isLoading: false, error: ''));
    } else {
      emitter(ProductErrorState(contentProduct: ContentProduct(), isLoading: false, error: content.erros[0]));
    }
  }

}