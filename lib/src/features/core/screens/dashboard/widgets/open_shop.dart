import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class OpenShop extends StatelessWidget {
  const OpenShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Image(image: const AssetImage(tSplashImage), color: AppColors.berimbau, height: height * 0.5),
                    Image(image: const AssetImage(tClosedImage), color: AppColors.berimbau, height: height * 0.5),
                    const Text("Desculpe, estamos fechados!", textAlign: TextAlign.center, style: TextStyle(color: AppColors.berimbau, fontSize: 20)),
                    const Text("Abriremos em breve!", textAlign: TextAlign.center, style: TextStyle(color: AppColors.berimbau, fontSize: 18)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
