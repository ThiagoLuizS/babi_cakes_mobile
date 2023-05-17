import 'package:babi_cakes_mobile/src/features/core/screens/shopping_cart/components/product_list_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/shopping_cart/shopping_cart_controller.dart';
import '../../../models/cupom/content_cupom.dart';
import '../../../theme/app_colors.dart';
import '../../components/body_cupom_cart_component.dart';

class BodyCupomAndProductShoppingCart extends StatelessWidget {
  const BodyCupomAndProductShoppingCart({
    Key? key,
    required this.contentCupom,
  }) : super(key: key);

  final ContentCupom contentCupom;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Flex(
              direction: Axis.vertical,
              children: [
                const Padding(
                  padding: EdgeInsets.all(6),
                  child: Divider(color: AppColors.grey),
                ),
                BodyCupomCartComponent(contentCupom: contentCupom, subTotalOrder: cart.totalPrice),
                const Padding(
                  padding: EdgeInsets.all(6),
                  child: Divider(color: AppColors.grey),
                ),
                cart.isProductDiscount && cart.cupomView != null
                    ? Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: AppColors.grey3),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Com o cupom aplicado, os descontos que os produtos já possuem serão substituidos pelo desconto do cupom aplicado ao pedido",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.clip),
                      ),
                    ),
                  ),
                )
                    : Container(),
                const ProductListShoppingCart(),
              ],
            ),
          );
        }
    );
  }
}