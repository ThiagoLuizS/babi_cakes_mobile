import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/shopping_cart/shopping_cart.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dashboard/widgets/bottom_navigation_bar_header.dart';

class Product extends StatefulWidget {
  final ProductView productView;

  const Product({Key? key, required this.productView}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  double valueFinal = 0.0;
  int _quantity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantity = 1;
    _calculateValueFinal();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Consumer<ShoppingCartController>(
        builder: (context, cart, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.small(
              onPressed: () => Get.offAll(() => const Dashboard()),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.berimbau,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            bottomNavigationBar: BottomNavigationBarHeader(cart: cart),
            body: Consumer<ShoppingCartController>(
              builder: (context, cart, child) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: [
                              SizedBox(
                                height: 220,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(base64Decode(widget
                                            .productView.productFileView.photoBase64ToString))),
                                    borderRadius: BorderRadius.circular(10),
                                    color: tCardBgColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.productView.name,
                                      style: GoogleFonts.notoSansCarian(fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        widget.productView.description,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1, color: Color(0x32989191)),
                                            bottom:
                                            BorderSide(width: 1, color: Color(0x32989191)),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.ac_unit_outlined,
                                                color: Colors.lightBlue,
                                                size: 20,
                                              ),
                                              Text(
                                                widget.productView.tag,
                                                style: const TextStyle(
                                                    fontSize: 12, color: Colors.lightBlueAccent),
                                              ),
                                              const Expanded(
                                                child: Icon(
                                                  Icons.help_center_outlined,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            UtilBrasilFields.obterReal(widget.productView.value - widget.productView.discountValue, moeda: true, decimal: 2),// '${'R\$ '}${widget.productView.value.toString()}',
                                            style: const TextStyle(
                                                color: tGreebBgColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          widget.productView.existPercentage
                                              ? Text(
                                            UtilBrasilFields.obterReal(widget.productView.value, moeda: true, decimal: 2),
                                            style: const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: tSecondaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900),
                                          ) : Container(),
                                          widget.productView.existPercentage
                                              ? Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Container(
                                              height: 22,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: tGreebBgColor),
                                              child: Center(
                                                child: Text(
                                                  '-${NumberFormat.percentPattern("ar").format(widget.productView.percentageValue)}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(2),
                                          border: const Border(
                                            top: BorderSide(width: 1, color: Color(0x32989191)),
                                            bottom:
                                            BorderSide(width: 1, color: Color(0x32989191)),
                                            left: BorderSide(width: 1, color: Color(0x32989191)),
                                            right: BorderSide(width: 1, color: Color(0x32989191)),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: SizedBox(
                                              height: 80,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.menu_book_outlined,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: Text(
                                                          widget.productView.categoryView.name!,
                                                          style: const TextStyle(
                                                              fontSize: 14, color: AppColors.black54),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Divider(color: AppColors.black54),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.car_crash_outlined,
                                                          color: Colors.red,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Text(
                                                            '* 15-30 min * R\$ 4,30',
                                                            style: TextStyle(
                                                                color: tSecondaryColorV1,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Divider(color: AppColors.black54),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.message,
                                            color: Colors.grey,
                                            size: 25,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "observação?",
                                              style: TextStyle(
                                                  fontSize: 14, color: AppColors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        maxLength: 140,
                                        decoration: const InputDecoration(
                                          hintText: 'Ex: Tiras as nozes, morango, avelã',
                                          border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0x32989191))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              side: const BorderSide(color: Colors.white),
                                            ),
                                            onPressed: () {cart.removeItem(widget.productView);},
                                            child: Icon(
                                              Icons.remove,
                                              color: _quantity > 1 ? Colors.red : Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2),
                                            child: Text(cart.getQuantityByItem(widget.productView).toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2, right: 2),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(color: Colors.white),
                                              ),
                                              onPressed: () {cart.add(ShoppingCart(widget.productView, 1, widget.productView.value));},
                                              child: Icon(
                                                Icons.add,
                                                color: _quantity > 0 ? Colors.red : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.berimbau,
                                                  side: const BorderSide(color: Colors.white),
                                                ),
                                                onPressed: () {cart.add(ShoppingCart(widget.productView, 1, widget.productView.value));},
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.shopping_cart_checkout_outlined,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      const Text(
                                                        '',
                                                        style: TextStyle(
                                                            color: Colors.white, fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        UtilBrasilFields.obterReal(valueFinal, moeda: true, decimal: 2),
                                                        style: const TextStyle(
                                                            color: Colors.white, fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      ),
    );
  }

  _calculateValueFinal() {
    double value = (widget.productView.value - widget.productView.discountValue) * _quantity;
    setState(() {
      valueFinal = value;
    });
  }
}
