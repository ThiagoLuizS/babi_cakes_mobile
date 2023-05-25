import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/filter_param.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/search_product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../controllers/product/product_event.dart';
import '../../controllers/product/product_state.dart';
import '../../models/product/product_view.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  late final ProductBloc blocProduct;
  late String productName = '';
  late TextEditingController filterController = TextEditingController();
  late List<FilterParam> productFilterParams = FilterParam.listFilterProduct;
  late FilterParam filterParam = FilterParam();

  int pageSize = 4;

  @override
  void dispose() {
    blocProduct.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    blocProduct = ProductBloc();

    filterParam = FilterParam();
    productFilterParams = FilterParam.listFilterProduct;
    _onGetProductAll('', pageSize);

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarDefaultComponent(
          title: "Produtos",
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshIndicator();
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: blocProduct,
          builder: (context, state) {

            List<ProductView> productViewList = state.contentProduct.content ?? [];

            return SizedBox(
              height: height,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 2),
                      child: ListView.builder(
                        itemCount: productFilterParams.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (var element in productFilterParams) {
                                    if (element.selected) {
                                      element.selected = false;
                                    }
                                  }
                                  productFilterParams[index].selected = true;
                                  filterParam = productFilterParams[index];
                                });
                                _onGetProductAll(productName, pageSize);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: productFilterParams[index].selected
                                          ? Colors.white
                                          : AppColors.greyTransp200,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2.0, color: Colors.white)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            productFilterParams[index].name!,
                                            style: productFilterParams[index].selected
                                                ? const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)
                                                : const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: SearchProductComponent(
                              filterController: filterController
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _onGetProductAll(filterController.text, pageSize);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: BorderSide.none, foregroundColor: AppColors.grey3),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12, right: 16),
                          child: Text("Filtrar", style: TextStyle(color: AppColors.berimbau),),
                        ),
                      ),
                    ],
                  ),
                  !state.isLoading ? Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) =>
                          onNotification(scrollNotification, state.isLoading),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 20),
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 0.60),
                        scrollDirection: Axis.vertical,
                        itemCount: productViewList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.offAll(() => Product(
                                productView:
                                state.contentProduct.content![index])),
                            child: ProductComponent(
                                productView: productViewList[index],
                                isLoading: state.isLoading),
                          );
                        },
                      ),
                    ),
                  ) : ShimmerComponent(isLoading: state.isLoading, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tCardBgColor,
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tCardBgColor,
                        ),
                      ),
                    ],
                  )
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  _refreshIndicator() {
    _onGetProductAll(productName, pageSize);
  }

  bool onNotification(ScrollNotification scrollInfo, bool isLoading) {
    if (scrollInfo is ScrollEndNotification && !isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _onGetProductAll(productName, pageSize += 1);
    }
    return false;
  }

  _onGetProductAll(String productName, pageSize) async {
    blocProduct.add(LoadProductPageEvent(page: 0, size: pageSize, productName: productName, sort: filterParam.param!));
  }
}
