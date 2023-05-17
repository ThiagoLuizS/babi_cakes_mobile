import 'dart:math';

import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/models/charge/charge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../theme/app_colors.dart';

class PayPalIntegration {
  static getPaypal(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId: "",
        secretKey: "",
        returnURL: "br.com.babi_cakes_mobile",
        cancelURL: "br.com.babi_cakes_mobile",
        transactions: const [
          {
            "amount": {
              "total": '70',
              "currency": "BRL",
              "details": {
                "subtotal": '70',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": "Apple",
                  "quantity": 4,
                  "price": '5',
                  "currency": "BRL"
                },
                {
                  "name": "Pineapple",
                  "quantity": 5,
                  "price": '10',
                  "currency": "BRL"
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }

  static Future<dynamic> getPix(BuildContext context, double height, bool isDurationMessaCopy, Charge charge) {
    return showBarModalBottomSheet<void>(
      backgroundColor: Colors.white,
      expand: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState){
              return SizedBox(
                height: height / 2,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Flex(
                                direction: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text("Copie o pix para o pagamento"),
                                      ),
                                      isDurationMessaCopy ? Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: AppColors.grey2
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(child: Text("Pix copiado para área de transferência")),
                                        ),
                                      ) : Container(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {isDurationMessaCopy = true;});
                                                  Future.delayed(const Duration(seconds: 5), () async {
                                                    setState(() {isDurationMessaCopy = false;});
                                                  });
                                                  Clipboard.setData(ClipboardData(text: charge.brCode));
                                                },
                                                child: Text("copiar", style: TextStyle(color: AppColors.grey5),)
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.grey2
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(charge.brCode),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, top: 20),
                                            child: Stack(
                                              children: const [
                                                Image(
                                                    image: AssetImage(tClockImage),
                                                    width: 50,
                                                    height: 50,
                                                    color: Colors.grey
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: CircularProgressIndicator(color: Colors.green,),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10, top: 20),
                                            child: Center(
                                                child: Text(
                                                    "Aguardando pagamento...")),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }
}