import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/body_show_bar_shopping_cart_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ShoppingCartComponent extends StatefulWidget {
  const ShoppingCartComponent({Key? key}) : super(key: key);

  @override
  State<ShoppingCartComponent> createState() => _ShoppingCartComponentState();
}

class _ShoppingCartComponentState extends State<ShoppingCartComponent> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        return SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Future<void> future = showBarModalBottomSheet<void>(
                      backgroundColor: Colors.white,
                      expand: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const BodyShowBarShoppingCartComponent();
                      },
                    );
                    future.then((value) => {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.berimbau,
                      side: BorderSide.none),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                        const Text(
                          "Ver sacola",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          UtilBrasilFields.obterReal(cart.totalPrice,
                              moeda: true, decimal: 2),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
