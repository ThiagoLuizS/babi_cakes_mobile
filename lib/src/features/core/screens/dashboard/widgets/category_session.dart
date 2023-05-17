import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_item_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_list_category.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategorySession extends StatelessWidget {
  final List<CategoryView> categories;
  final CategoryBloc categoryBloc;

  const CategorySession({Key? key, required this.categories, required this.categoryBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        child: NotificationListener<ScrollNotification>(
          child: StreamBuilder<Object>(
            stream: categoryBloc.stream,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: GestureDetector(
                      onTap: () => Get.offAll(() => ProductListCategory(categoryView: categories[index])),
                      child: CategoryItemComponent(
                        category: categories[index],
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
