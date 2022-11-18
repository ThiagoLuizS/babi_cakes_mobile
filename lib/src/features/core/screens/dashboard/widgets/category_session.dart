import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_item_component.dart';
import 'package:flutter/material.dart';

class CategorySession extends StatelessWidget {
  final List<CategoryView> categories;

  const CategorySession({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: CategoryItemComponent(
                category: categories[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
