import 'package:babi_cakes_mobile/src/features/core/controllers/content_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/content_category.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/content_product.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_group_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/content_tab_bar_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/header_location_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_tab_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/banner_session.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/bottom_navigator.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/category_session.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';

import '../../controllers/category/category_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController? tabController;
  final controller = ContentController();
  final _bloc = CategoryBloc();
  late ContentCategory contentCategory = ContentCategory(content: []);
  final ProductBloc _productBloc = ProductBloc();
  late ContentProduct contentProduct = ContentProduct(content: [], empty: true);
  late CategoryView categoryView;
  late int currentIndexTab = 0;
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
    _productBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onGetCategoryAll();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Rua Flores do Campo, Bariri - São Paulo',
          style: AppTypography.localTextStyle(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ContentTabBarComponent(
          content: contentCategory.content,
          controller: tabController!,
        ),
      ),
      // bottomNavigationBar: BottomNavigator(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }

  _onGetCategoryAll() async {
    ApiResponse<ContentCategory> response = await _bloc.getAllByPage(0, 10);

    if (response.ok) {
      response.result.content
          .insert(0, CategoryView(id: 0, name: "Inicio", show: false));
      TabController tab =
          TabController(length: contentCategory.content.length, vsync: this);

      setState(() {
        contentCategory = response.result;
        tabController = tab;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
