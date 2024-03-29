import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/content_address.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/message_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_form_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_address_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../shopping_cart/body_show_bar_shopping_cart_component.dart';

class ProfileAddressScreen extends StatefulWidget {
  final bool originShoppingCart;
  const ProfileAddressScreen({Key? key, this.originShoppingCart = false}) : super(key: key);

  @override
  State<ProfileAddressScreen> createState() => _ProfileAddressScreenState();
}

class _ProfileAddressScreenState extends State<ProfileAddressScreen> {
  late ContentAddress contentAddress = ContentAddress(content: []);
  final _blocAddress = ProfileBloc();
  late bool isLoading = true;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  void dispose() {
    super.dispose();
    _blocAddress.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getAddressPageByUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          if(widget.originShoppingCart) {
            Get.offAll(() => const BodyShowBarShoppingCartComponent());
          } else {
            Get.offAll(() => const Dashboard(indexBottomNavigationBar: 3));
          }

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
          title: "Endereço",
        ),
      ),
      body: LiquidRefreshComponent(
        onRefresh: () async => _getAddressPageByUser(),
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: AppColors.greyTransp200, side: BorderSide(width: 0, color: Colors.white)),
                      onPressed: () => Get.offAll(() => ProfileAddressFormScreen(addressView: AddressView(-1),)),
                      child: const Icon(Icons.add, color: Colors.black87,),
                    ),
                  ),
                ),
                contentAddress.content.isEmpty ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: MessageComponent(message: 'Cadastre um novo endereço'),
                  ),
                ) : Container(),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: contentAddress.content.length,
                      itemBuilder: (BuildContext itemBuilder, index) {
                        AddressView address = contentAddress.content[index];
                        return ShimmerComponent(
                          isLoading: isLoading,
                          child: ProfileAddressCardComponent(
                            onTapUpdateMain: () => _updateAddressMain(address.id),
                            onTabDeleteAddress: () {_deleteAddress(address.id);},
                            onUpdateAddress: () {Get.offAll(() => ProfileAddressFormScreen(addressView: contentAddress.content[index],));},
                            addressView: address,
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
      ),
    );
  }

  _deleteAddress(id) async {
    ApiResponse<bool> response =
    await _blocAddress.deleteAddress(id);

    if (response.ok) {
      _getAddressPageByUser();
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }

  _getAddressPageByUser() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<ContentAddress> response =
        await _blocAddress.getAddressPageByUser();

    if (response.ok) {
      setState(() {
        contentAddress = response.result;
        isLoading = false;
      });
    }
  }

  _updateAddressMain(int id) async {
    ApiResponse<ContentAddress> response =
        await _blocAddress.updateAddressMain(id);

    if (response.ok) {
      _getAddressPageByUser();
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }
}
