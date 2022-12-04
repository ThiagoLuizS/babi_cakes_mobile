import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/profile/profile_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/content_cupom.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_cupom_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyShowBarCupomShoppingCartComponent extends StatefulWidget {
  final ContentCupom contentCupom;

  const BodyShowBarCupomShoppingCartComponent(
      {Key? key, required this.contentCupom})
      : super(key: key);

  @override
  State<BodyShowBarCupomShoppingCartComponent> createState() =>
      _BodyShowBarCupomShoppingCartComponentState();
}

class _BodyShowBarCupomShoppingCartComponentState
    extends State<BodyShowBarCupomShoppingCartComponent> {
  final ProfileBloc _blocProfile = ProfileBloc();
  late bool isLoading = true;

  @override
  void dispose() {
    super.dispose();
    _blocProfile.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          Navigator.pop(context);
        }
        return Scaffold(
          body: SizedBox(
              height: height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0, color: AppColors.white),
                        color: Colors.white,
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
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const RotationTransition(
                              turns:
                              AlwaysStoppedAnimation(330 / 360),
                              child: Image(
                                  image:
                                  AssetImage(tProfileCupomImage),
                                  width: 25,
                                  height: 25,
                                  color: AppColors.berimbau),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sem cupom", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                Text("Nenhum cupom aplicado", style: TextStyle(color: Colors.grey, fontSize: 13))
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.white,
                                side: BorderSide.none,
                              ),
                              onPressed: () {
                                cart.removeCupom();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Selecionar",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: widget.contentCupom.content.length,
                        itemBuilder: (BuildContext itemBuilder, index) {
                          CupomView cupom = widget.contentCupom.content[index];
                          return ProfileCupomCardComponent(
                            onTap: () {
                              cart.addCupom(cupom);
                              Navigator.pop(context);
                            },
                            cupomView: cupom,
                            textButtomSelected: "Selecionar",
                            cupomSelectedBudget: cart.cupomView != null,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
