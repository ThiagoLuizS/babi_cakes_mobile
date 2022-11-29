import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_search.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_address_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_cupom_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../components/shimmer_component.dart';

class ProfileCupomScreen extends StatefulWidget {
  const ProfileCupomScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCupomScreen> createState() => _ProfileCupomScreenState();
}

class _ProfileCupomScreenState extends State<ProfileCupomScreen> {
  late ContentCupom contentCupom = ContentCupom(content: []);
  final _blocProfile = ProfileBloc();
  late bool isLoading = true;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blocProfile.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCupomByUserAndCupomStatusEnum();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          push(context, const Dashboard(indexBottomNavigationBar: 3), replace: true);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.berimbau,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarDefaultComponent(
          title: "Cupons",
        ),
      ),
      body: LiquidRefreshComponent(
        onRefresh: () async => _getCupomByUserAndCupomStatusEnum(),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: contentCupom.content.length,
                    itemBuilder: (BuildContext itemBuilder, index) {
                      CupomView cupom = contentCupom.content[index];
                      return ShimmerComponent(
                        isLoading: isLoading,
                        child: ProfileCupomCardComponent(
                          onTap: () => push(context, const Dashboard(indexBottomNavigationBar: 1), replace: true),
                          cupomView: cupom,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCupomByUserAndCupomStatusEnum() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentCupom> response =
    await _blocProfile.getCupomByUserAndCupomStatusEnum();

    if (response.ok) {
      setState(() {
        contentCupom = response.result;
        isLoading = false;
      });
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey);
    }
  }
}
