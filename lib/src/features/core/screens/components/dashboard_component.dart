import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_group_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/category_session.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

class DashboardComponent extends StatefulWidget {
  const DashboardComponent({Key? key}) : super(key: key);

  @override
  State<DashboardComponent> createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> with SingleTickerProviderStateMixin {
  final ProductBloc _productBloc = ProductBloc();
  final CategoryBloc _categoryBloc = CategoryBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);
  late bool isLoadingProducts = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productBloc.dispose();
    _categoryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetCategoryAll();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CategorySession(categories: contentCategory.content),
          BannerSession(),
          SliverList(
            delegate: SliverChildListDelegate(
              contentCategory.content
                  .map(
                    (e) => CategoryGroupItemComponent(
                  categoryView: _setStateCategoryView(e)),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  CategoryView _setStateCategoryView(CategoryView categoryView) {
    setState(() {
      categoryView = categoryView;
    });

    return categoryView;
  }

  _onGetCategoryAll() async {
    ApiResponse<ContentCategory> response = await _categoryBloc.getAllByPage(0, 10);

    if (response.ok) {
      response.result.content.insert(0, CategoryView(id: 0, name: "Início", show: false));

      setState(() {
        contentCategory = response.result;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}