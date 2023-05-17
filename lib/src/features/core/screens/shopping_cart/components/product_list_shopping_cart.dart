import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../controllers/shopping_cart/shopping_cart_controller.dart';
import '../../../models/shopping_cart/shopping_cart.dart';

class ProductListShoppingCart extends StatelessWidget {
  const ProductListShoppingCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartController>(
      builder: (context, cart, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cart.items.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext itemBuilder, index) {
            ShoppingCart shoppingCart = cart.items[index];
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(
                            base64Decode(shoppingCart
                                .product
                                .productFileView
                                .photoBase64ToString),
                          )),
                      borderRadius:
                      BorderRadius.circular(10),
                      color: tCardBgColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8),
                        child: Text(
                          shoppingCart.product.name,
                          style: const TextStyle(
                              color: Color.fromARGB(
                                  245, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              overflow:
                              TextOverflow.clip),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              shoppingCart.product
                                  .existPercentage &&
                                  cart.cupomView ==
                                      null
                                  ? Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        left:
                                        8),
                                    child: Text(
                                      UtilBrasilFields.obterReal(
                                          (shoppingCart
                                              .product
                                              .value -
                                              shoppingCart
                                                  .product
                                                  .discountValue) * shoppingCart.quantity,
                                          moeda:
                                          true,
                                          decimal:
                                          2),
                                      style: const TextStyle(
                                          color:
                                          tGreebBgColor,
                                          fontSize:
                                          14,
                                          fontWeight:
                                          FontWeight
                                              .w900),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        left:
                                        5),
                                    child:
                                    Container(
                                      height: 22,
                                      width: 38,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              4),
                                          color:
                                          tGreebBgColor),
                                      child: Center(
                                        child: Text(
                                          '-${NumberFormat.percentPattern("ar").format(shoppingCart.product.percentageValue)}',
                                          style: const TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize:
                                              12,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                                  : Container(),
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 8, top: 5),
                                child: Text(
                                  UtilBrasilFields
                                      .obterReal(
                                      shoppingCart
                                          .amount,
                                      moeda: true,
                                      decimal: 2),
                                  style: TextStyle(
                                      decoration: shoppingCart
                                          .product
                                          .existPercentage &&
                                          cart.cupomView ==
                                              null
                                          ? TextDecoration
                                          .lineThrough
                                          : TextDecoration
                                          .none,
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 2, bottom: 2),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    5),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color:
                                    Color(0x32989191),
                                    offset:
                                    Offset(0.4, 0.4),
                                    blurRadius: 1.4,
                                    spreadRadius: 1.4,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton
                                        .styleFrom(
                                      backgroundColor:
                                      Colors.white,
                                      side:
                                      const BorderSide(
                                          color: Colors
                                              .white),
                                    ),
                                    onPressed: () {
                                      cart.removeItem(
                                          shoppingCart
                                              .product);
                                    },
                                    child: Icon(
                                      shoppingCart.quantity ==
                                          1
                                          ? Icons
                                          .delete_forever_sharp
                                          : Icons.remove,
                                      color: shoppingCart
                                          .quantity >=
                                          1
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        left: 0,
                                        top: 7),
                                    child: Text(cart
                                        .getQuantityByItem(
                                        shoppingCart
                                            .product)
                                        .toString()),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        left: 2,
                                        right: 2),
                                    child: ElevatedButton(
                                      style:
                                      ElevatedButton
                                          .styleFrom(
                                        backgroundColor:
                                        Colors.white,
                                        side: const BorderSide(
                                            color: Colors
                                                .white),
                                      ),
                                      onPressed: () {
                                        cart.add(
                                            shoppingCart);
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: shoppingCart
                                            .quantity >
                                            0
                                            ? Colors.red
                                            : Colors.grey,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }
}