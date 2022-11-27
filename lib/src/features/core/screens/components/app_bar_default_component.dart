import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarDefaultComponent extends StatelessWidget {
  final String title;

  const AppBarDefaultComponent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: AppColors.white,
      flexibleSpace: const SizedBox(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
      ),
      title: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
