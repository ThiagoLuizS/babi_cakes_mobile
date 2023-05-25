import 'dart:async';

import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/parameterization/parameterization_bloc.dart';
import '../../../controllers/parameterization/parameterization_event.dart';
import '../../../controllers/parameterization/parameterization_state.dart';
import '../../../theme/app_colors.dart';

class OpenShop extends StatefulWidget {
  const OpenShop({Key? key}) : super(key: key);

  @override
  State<OpenShop> createState() => _OpenShopState();
}

class _OpenShopState extends State<OpenShop> {

  late final ParameterizationBloc blocParameterization;


  @override
  void dispose() {
    blocParameterization.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    blocParameterization = ParameterizationBloc();

    _getParameterization();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocConsumer<ParameterizationBloc, ParameterizationState>(
      bloc: blocParameterization,
      listener: (context, state) {
        if(state.parameterizationView.openShop!) {
          Get.offAll(() => const Dashboard());
        }
      },
      builder: (context, state) {
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
                        Image(image: const AssetImage(tSplashImage), color: AppColors.berimbau, height: height * 0.4),
                        Image(image: const AssetImage(tClosedImage), color: AppColors.berimbau, height: height * 0.2),
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
    );
  }

  _getParameterization() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if(mounted) {
        blocParameterization.add(LoadParameterizationEvent());
      }
    });
  }
}
