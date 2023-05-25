import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/filter_param.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/search_product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../controllers/product/product_event.dart';
import '../../controllers/product/product_state.dart';
import '../../models/product/product_view.dart';
import '../components/shimmer_component.dart';
import '../dashboard/widgets/bottom_navigation_bar_header.dart';

class ProductListCategory extends StatefulWidget {
  final CategoryView categoryView;

  const ProductListCategory({Key? key, required this.categoryView})
      : super(key: key);

  @override
  State<ProductListCategory> createState() => _ProductListCategoryState();
}

class _ProductListCategoryState extends State<ProductListCategory> {
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
    _onGetProductAll(widget.categoryView.id!, productName, pageSize);

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Consumer<ShoppingCartController>(
        builder: (context, cart, child) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: FloatingActionButton.small(
              onPressed: () => Get.offAll(() => const Dashboard()),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.berimbau,
              ),
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBarDefaultComponent(
                title: widget.categoryView.name!.toUpperCase(),
              ),
            ),
            bottomNavigationBar: BottomNavigationBarHeader(cart: cart),
            extendBody: true,
            body: LiquidRefreshComponent(
              onRefresh: () async {
                return _refreshIndicator();
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
                                        _onGetProductAll(widget.categoryView.id!, productName, pageSize);
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
                                  _onGetProductAll(widget.categoryView.id!,
                                      filterController.text, pageSize);
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
                              child: productViewList.isNotEmpty
                                  ? NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) =>
                                    onNotification(scrollNotification, state.isLoading),
                                child: StreamBuilder<Object>(
                                    stream: blocProduct.stream,
                                    builder: (context, snapshot) {
                                      return GridView.builder(
                                        padding: const EdgeInsets.only(top: 20),
                                        physics:
                                        const AlwaysScrollableScrollPhysics(),
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
                                                productView: productViewList[index])),
                                            child: ProductComponent(
                                                productView:
                                                productViewList[index]),
                                          );
                                        },
                                      );
                                    }),
                              )
                                  : MessageComponent()
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
                          )),
                        ],
                      ),
                    );
                  }
              ),
            ),
          );
        }
      ),
    );
  }

  _refreshIndicator() {
    _onGetProductAll(widget.categoryView.id!, productName, pageSize);
  }

  bool onNotification(ScrollNotification scrollInfo, bool isLoading) {
    if (scrollInfo is ScrollEndNotification && !isLoading && scrollInfo.metrics.pixels ==
        scrollInfo.metrics.maxScrollExtent) {
      _onGetProductAll(widget.categoryView.id!, productName, pageSize += 1);
    }
    return false;
  }

  _onGetProductAll(int categoryId, String productName, pageSize) async {
    blocProduct.add(LoadProductByCategoryPageEvent(page: 0, size: pageSize, categoryId: categoryId, productName: productName, sort: filterParam.param!));
  }
}
