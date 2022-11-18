import 'package:babi_cakes_mobile/src/constants/sizes.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/category/category_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/product_for_category_dashboard_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/categories.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoryGroupItemComponent extends StatefulWidget {
  final CategoryView categoryView;
  final List<CategoryView> categoryViewList;
  final int itemCount;

  const CategoryGroupItemComponent(
      {Key? key,
      required this.categoryView,
      required this.itemCount,
      required this.categoryViewList})
      : super(key: key);

  @override
  _CategoryGroupItemComponentState createState() =>
      _CategoryGroupItemComponentState();
}

class _CategoryGroupItemComponentState
    extends State<CategoryGroupItemComponent> {
  final CategoryBloc _bloc = CategoryBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 40),
              child: Text(
                widget.categoryView.name,
                style: AppTypography.sessionTitle(
                  context,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12, top: 40),
              child: Text(
                "Ver mais",
                style: TextStyle(fontSize: 13, color: AppColors.berimbau),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 260,
                child: ListView.builder(
                  itemCount: widget.itemCount,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    child: SizedBox(
                      height: 260,
                      child: ProductForCategoryDashboardComponent(
                        categoryView: widget.categoryViewList[index],
                        txtTheme: txtTheme,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
