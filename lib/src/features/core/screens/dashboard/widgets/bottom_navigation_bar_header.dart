import 'package:flutter/material.dart';

import '../../../controllers/shopping_cart/shopping_cart_controller.dart';
import '../../shopping_cart/shopping_cart_component.dart';

class BottomNavigationBarHeader extends StatelessWidget {
  final ShoppingCartController cart;

  const BottomNavigationBarHeader({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cart.items.isNotEmpty ? 130:0,
      child: Column(
        children: [
          cart.items.isNotEmpty ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ShoppingCartComponent(),
          ): Container()
        ],
      ),
    );
  }
}
