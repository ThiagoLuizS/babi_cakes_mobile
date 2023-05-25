import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_state.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_list_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CategorySessionView extends StatefulWidget {
  const CategorySessionView({Key? key}) : super(key: key);

  @override
  State<CategorySessionView> createState() => _CategorySessionViewState();
}

class _CategorySessionViewState extends State<CategorySessionView> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return SizedBox(
          height: 100,
          child: NotificationListener<ScrollNotification>(
            child: ListView.builder(
              itemCount: state.categoryListView.length,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: GestureDetector(
                    onTap: () => Get.offAll(() => ProductListCategory(categoryView: state.categoryListView[index])),
                    child: CategoryItemComponent(
                      category: state.categoryListView[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}
