import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:babi_cakes_mobile/src/constants/colors.dart';

class BudgetForgetFormPayment extends StatelessWidget {
  const BudgetForgetFormPayment({
    required this.btnImage,
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String btnImage;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    //Use for Dark Theme
    final bool isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isDark ? tSecondaryColor : Colors.grey.shade200,
          // color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Image(
                image: AssetImage(btnImage),
                width: 100,
                height: 50,
                color: AppColors.berimbau),
            const SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 80,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: Theme.of(context).textTheme.headline6),
                              Text(subTitle, style: Theme.of(context).textTheme.bodyText2),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
