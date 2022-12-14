import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/component/profile_address_description_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileAddressCardComponent extends StatefulWidget {
  final AddressView addressView;
  final Function onTapUpdateMain;
  final Function onTabDeleteAddress;
  final Function onUpdateAddress;

  const ProfileAddressCardComponent(
      {Key? key, required this.addressView, required this.onTapUpdateMain, required this.onTabDeleteAddress, required this.onUpdateAddress})
      : super(key: key);

  @override
  State<ProfileAddressCardComponent> createState() =>
      _ProfileAddressCardComponentState();
}

class _ProfileAddressCardComponentState
    extends State<ProfileAddressCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          widget.onTapUpdateMain();
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: widget.addressView.addressMain
                ? Border.all(width: 2, color: AppColors.berimbau)
                : Border.all(width: 0, color: Colors.white),
            boxShadow: const [
              BoxShadow(
                color: Color(0x32989191),
                offset: Offset(0.3, 0.3),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.home_work_outlined),
                Expanded(
                    child: ProfileAddressDescriptionComponent(
                  addressView: widget.addressView,
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showBarOption();
                      },
                      child: const Icon(Icons.more_vert),
                    ),
                    widget.addressView.addressMain
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.berimbau,
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showBarOption() {
    Future<void> future = showBarModalBottomSheet<void>(
      expand: false,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: AppColors.greyTransp200, side: BorderSide(width: 0, color: Colors.white)),
                      onPressed: () => {widget.onUpdateAddress()},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.edit, color: Colors.black87,),
                          Text("Editar", style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: AppColors.greyTransp200, side: const BorderSide(width: 0, color: Colors.white)),
                      onPressed: () => {widget.onTabDeleteAddress(), Navigator.pop(context)},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete_outline_outlined, color: Colors.black87,),
                          Text("Excluir", style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    future.then((value) => {});
  }
}
