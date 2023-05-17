import 'package:flutter/material.dart';

import '../../../models/profile/address_view.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_icons.dart';
import '../../components/shimmer_component.dart';
import '../../profile/address/component/profile_address_description_component.dart';
import 'package:get/get.dart';

import '../../profile/address/profile_address_screen.dart';

class AddressShoppingCart extends StatelessWidget {
  const AddressShoppingCart({
    Key? key,
    required this.isLoading,
    required this.addressView,
  }) : super(key: key);

  final bool isLoading;
  final AddressView? addressView;

  @override
  Widget build(BuildContext context) {
    return ShimmerComponent(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () => Get.offAll(() => const ProfileAddressScreen()),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: addressView != null
                ? [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: AppIcon(
                  AppIcons.mapShoppingCart,
                  color: AppColors.milkCream,
                  size: Size(70, 70),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                      EdgeInsets.only(left: 16),
                      child: Text(
                        "Entregar em",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 13),
                      ),
                    ),
                    ProfileAddressDescriptionComponent(
                      addressView: addressView!,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => const ProfileAddressScreen());
                },
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.red,
                  size: 17,
                ),
              )
            ]
                : [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:
                        AppColors.greyTransp100,
                        side: const BorderSide(
                            width: 1,
                            color: Colors.red)),
                    onPressed: () => Get.offAll(() =>
                    const ProfileAddressScreen()),
                    child: const Text(
                      "Cadastre um endereço",
                      style: TextStyle(
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}