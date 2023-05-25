import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../controllers/category/category_state.dart';
import '../../components/category_group_item_component.dart';
import '../../product/product_list_category.dart';

class GroupProductSessionView extends StatefulWidget {
  const GroupProductSessionView({Key? key}) : super(key: key);

  @override
  State<GroupProductSessionView> createState() => _GroupProductSessionViewState();
}

class _GroupProductSessionViewState extends State<GroupProductSessionView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: state.categoryListView.map((e) => GestureDetector(
                onTap: () => Get.offAll(() => ProductListCategory(categoryView: e)),
                child: CategoryGroupItemComponent(
                    categoryView: e, isLoading: false
                )
            )).toList(),
          ),
        );
      }
    );
  }
}


