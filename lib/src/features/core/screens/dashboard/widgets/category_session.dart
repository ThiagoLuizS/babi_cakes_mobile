import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/category_item_component.dart';
import 'package:flutter/material.dart';

class CategorySession extends StatelessWidget {
  final List<CategoryView> categories;
  final CategoryBloc categoryBloc;

  const CategorySession({Key? key, required this.categories, required this.categoryBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
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
                    child: CategoryItemComponent(
                      category: categories[index],
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

  bool onNotification(ScrollNotification scrollInfo) {
    print(scrollInfo);
    if (scrollInfo is OverscrollNotification) {
      print("Entrou");
    }
    return false;
  }
}
