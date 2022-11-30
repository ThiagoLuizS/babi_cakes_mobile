import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_group_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/category_session.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardComponent extends StatefulWidget {
  const DashboardComponent({Key? key}) : super(key: key);

  @override
  State<DashboardComponent> createState() => _DashboardComponentState();
}

class _DashboardComponentState extends State<DashboardComponent> with SingleTickerProviderStateMixin {
  final _productBloc = ProductBloc();
  final _categoryBloc = CategoryBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);
  late bool isLoadingProducts = false;

  @override
  void dispose() {
    _categoryBloc.dispose();
    _productBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetCategoryAll();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return LiquidRefreshComponent(
      onRefresh: () async => Get.offAll(() => const Dashboard()),
      child: SizedBox(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            CategorySession(categories: contentCategory.content, categoryBloc: _categoryBloc),
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
      // ignore: use_build_context_synchronously
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}