import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/shopping_cart/shopping_cart_controller.dart';

class HeaderShoppingCart extends StatelessWidget {
  const HeaderShoppingCart({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: width / 4),
              child: IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(
                      Icons.arrow_downward_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(right: width / 4),
              child: const Text(
                "SACOLA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            IconButton(
                onPressed: () {
                  cart.removeAll();
                },
                icon:
                const Icon(Icons.delete_outline_outlined)),
          ],
        );
      }
    );
  }
}
