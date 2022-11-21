import 'dart:convert';

import 'package:babi_cakes_mobile/src/constants/colors.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductComponent extends StatefulWidget {
  final ProductView productView;
  final bool isLoading;

  const ProductComponent({Key? key, required this.productView, required this.isLoading})
      : super(key: key);

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerComponent(
          isLoading: widget.isLoading,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(base64Decode(
                      widget.productView.productFileView.photoBase64ToString))),
              borderRadius: BorderRadius.circular(10),
              color: tCardBgColor,
            ),
          ),
        ),
        Container(
          height: 150,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tWhiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    ShimmerComponent(
                      isLoading: widget.isLoading,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                          UtilBrasilFields.obterReal(widget.productView.value, moeda: true, decimal: 2),// '${'R\$ '}${widget.productView.value.toString()}',
                            style: const TextStyle(
                                color: tGreebBgColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
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
                    ShimmerComponent(
                      isLoading: widget.isLoading,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.productView.existPercentage
                              ? Text(
                            UtilBrasilFields.obterReal(widget.productView.value - widget.productView.discountValue, moeda: true, decimal: 2),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: tSecondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w900),
                          ) : Container(),
                        ],
                      )
                    ),
                    ShimmerComponent(
                      isLoading: widget.isLoading,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                widget.productView.name,
                                style: TextStyle(
                                    color: tDarkColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    overflow: widget.productView.name.length > 43 ? TextOverflow.ellipsis : TextOverflow.visible),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ShimmerComponent(
                      isLoading: widget.isLoading,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Flexible(
                              child: Text(
                                '15-30 min * R\$ 4,30',
                                style: TextStyle(
                                    color: tSecondaryColorV1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
