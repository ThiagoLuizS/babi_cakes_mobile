import 'dart:convert';

import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoryItemComponent extends StatelessWidget {
  final CategoryView category;

  const CategoryItemComponent({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return category.show ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(image: MemoryImage(base64Decode(category.categoryFileView!.photoBase64ToString)))
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              category?.name ?? '',
              style:
                  AppTypography.medium(context)?.copyWith(color: AppColors.black54),
            ),
          ),
        ),
      ],
    ) : Container();
  }
}
