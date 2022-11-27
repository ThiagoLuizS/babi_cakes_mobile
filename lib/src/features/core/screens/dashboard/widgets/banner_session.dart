import 'package:babi_cakes_mobile/src/features/core/screens/components/banners_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class BannerSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: const BannersComponent(
        list: [
          BannerItemComponent(
            imagePath: AppImages.banner1,
          ),
          BannerItemComponent(
            imagePath: AppImages.banner2,
          ),
          BannerItemComponent(
            imagePath: AppImages.banner3,
          ),
          BannerItemComponent(
            imagePath: AppImages.banner4,
          )
        ],
      ),
    );
  }
}