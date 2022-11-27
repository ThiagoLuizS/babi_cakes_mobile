import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAddressCardComponent extends StatefulWidget {
  final AddressView addressView;
  final Function onTapUpdateMain;

  const ProfileAddressCardComponent({Key? key, required this.addressView, required this.onTapUpdateMain})
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
      padding: const EdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: () {widget.onTapUpdateMain();},
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
                offset: Offset(0.4, 0.4),
                blurRadius: 1.4,
                spreadRadius: 1.4,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          '${widget.addressView.addressType} ${widget.addressView.addressName}, ${widget.addressView.number} - ${widget.addressView.complement}',
                          style: const TextStyle(
                              color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          '${widget.addressView.district} - ${widget.addressView.city} - ${widget.addressView.state}',
                          style: const TextStyle(
                              color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
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
}
