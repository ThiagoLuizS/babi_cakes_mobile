import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/body_show_bar_cupom_shopping_cart_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BodyCupomCartComponent extends StatefulWidget {
  final ContentCupom contentCupom;
  final double subTotalOrder;

  const BodyCupomCartComponent({Key? key, required this.contentCupom, required this.subTotalOrder})
      : super(key: key);

  @override
  State<BodyCupomCartComponent> createState() => _BodyCupomCartComponentState();
}

class _BodyCupomCartComponentState extends State<BodyCupomCartComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        return ElevatedButton(
          onPressed: () {
            if (widget.contentCupom.content.isNotEmpty) {
              _showBarCupom(cart.totalPrice);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white, side: BorderSide.none),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const RotationTransition(
                      turns: AlwaysStoppedAnimation(330 / 360),
                      child: Image(
                          image: AssetImage(tProfileCupomImage),
                          width: 25,
                          height: 25,
                          color: AppColors.berimbau),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: cart.cupomView == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Cupom",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    '${widget.contentCupom.content.length} para usar nesta loja',
                                    style: const TextStyle(color: AppColors.grey),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${UtilBrasilFields.obterReal(cart.cupomView!.cupomValue, moeda: true, decimal: 2)} para usar em todos os produtos',
                                  style: const TextStyle(
                                      color: Color.fromARGB(175, 0, 0, 0),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Cupom aplicado",
                                    style: TextStyle(
                                        fontSize: 12, color: AppColors.grey),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ],
                ),
                cart.cupomView == null
                    ? const Text(
                  "Adicionar",
                  style: TextStyle(color: Colors.red),
                ) : const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.red,
                  size: 16,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showBarCupom(totalPrice) {
    Future<void> future = showBarModalBottomSheet<void>(
      expand: true,
      context: context,
      builder: (BuildContext context) {
        return BodyShowBarCupomShoppingCartComponent(
            contentCupom: widget.contentCupom, subTotalOrder: totalPrice);
      },
    );
    future.then((value) => {});
  }
}
