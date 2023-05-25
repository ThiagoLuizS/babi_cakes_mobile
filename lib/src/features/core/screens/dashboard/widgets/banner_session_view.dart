import 'package:babi_cakes_mobile/src/features/core/controllers/banner/banner_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/banners_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/image_strings.dart';
import '../../../controllers/banner/banner_state.dart';
import '../../../theme/app_colors.dart';

class BannerSessionView extends StatefulWidget {
  const BannerSessionView({Key? key}) : super(key: key);

  @override
  State<BannerSessionView> createState() => _BannerSessionViewState();
}

class _BannerSessionViewState extends State<BannerSessionView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: height / 3,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
                    color: AppColors.milkCream
                ),
                child: Image(image: const AssetImage(tSplashImage), color: AppColors.berimbau, height: height * 0.6),
              ),
            ),
            BannersComponent(
                list: state.bannerListView.map((e) => BannerItemComponent(view: e,)).toList()
            ),
          ]
        );
      }
    );
  }
}