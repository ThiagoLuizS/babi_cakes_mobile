import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:flutter/material.dart';

class ProfileAddressDescriptionComponent extends StatelessWidget {
  final AddressView addressView;
  const ProfileAddressDescriptionComponent({Key? key, required this.addressView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            '${addressView.addressType} ${addressView.addressName}, ${addressView.number} - ${addressView.complement}',
            style: const TextStyle(
                color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            '${addressView.district} - ${addressView.city} - ${addressView.state}',
            style: const TextStyle(
                color: Color.fromARGB(175, 0, 0, 0), fontSize: 13),
          ),
        )
      ],
    );
  }
}
