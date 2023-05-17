import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/filter_param.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/search_product_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  late ContentProduct contentProduct = ContentProduct(content: []);
  final ProductBloc _productBloc = ProductBloc();
  late bool isLoading = true;
  late String productName = '';
  late TextEditingController filterController = TextEditingController();
  late List<FilterParam> productFilterParams = FilterParam.listFilterProduct;
  late FilterParam filterParam = FilterParam();

  int pageSize = 4;

  @override
  void dispose() {
    _productBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    filterParam = FilterParam();
    productFilterParams = FilterParam.listFilterProduct;
    _onGetProductAll('', pageSize);
    super.initState();
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
        child: SizedBox(
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
                        filterController: filterController,
                        productBloc: _productBloc
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
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) =>
                      onNotification(scrollNotification),
                  child: StreamBuilder<Object>(
                      stream: _productBloc.stream,
                      builder: (context, snapshot) {
                        return GridView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 0.60),
                          scrollDirection: Axis.vertical,
                          itemCount: contentProduct.content.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.offAll(() => Product(
                                  productView:
                                  contentProduct.content[index])),
                              child: ProductComponent(
                                  productView: contentProduct.content[index],
                                  isLoading: isLoading),
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _refreshIndicator() {
    _onGetProductAll(productName, pageSize);
  }

  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        !isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _onGetProductAll(productName, pageSize += 1);
    }
    return false;
  }

  _onGetProductAll(String productName, pageSize) async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentProduct> response =
        await _productBloc.getAllByPage(0, pageSize, productName, filterParam.param!);

    if (response.ok && mounted) {
      setState(() {
        contentProduct = response.result;
        isLoading = false;
      });
    }
  }
}
