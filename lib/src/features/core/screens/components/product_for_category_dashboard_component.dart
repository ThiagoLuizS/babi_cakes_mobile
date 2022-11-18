import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/models/category/category_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProductForCategoryDashboardComponent extends StatelessWidget {
  final CategoryView categoryView;

  const ProductForCategoryDashboardComponent({
    Key? key,
    required this.categoryView,
    required this.txtTheme,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(base64Decode(
                      categoryView.categoryFileView.photoBase64ToString))),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: tCardBgColor,
            ),
          ),
          Container(
            height: 150,
            width: 180,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0)),
              color: tWhiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'R 12,50',
                            style: TextStyle(
                                color: tGreebBgColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                          const Text(
                            'R 12,50',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                                color: tSecondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w900),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: 22,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: tGreebBgColor),
                              child: const Center(
                                child: Text(
                                  '-19%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Flexible(
                              child: Text(
                                'Bolo de pote especial com cobertura de chocolate',
                                style: TextStyle(
                                    color: tDarkColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
