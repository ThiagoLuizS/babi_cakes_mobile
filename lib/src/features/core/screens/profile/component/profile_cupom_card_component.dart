import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileCupomCardComponent extends StatefulWidget {
  final CupomView cupomView;
  final Function onTap;
  final String textButtomSelected;
  final bool cupomSelectedBudget;

  const ProfileCupomCardComponent(
      {Key? key, required this.cupomView, required this.onTap, this.textButtomSelected = "Ver produtos", this.cupomSelectedBudget = false})
      : super(key: key);

  @override
  State<ProfileCupomCardComponent> createState() =>
      _ProfileCupomCardComponentState();
}

class _ProfileCupomCardComponentState extends State<ProfileCupomCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: widget.cupomSelectedBudget ? Border.all(width: 2, color: AppColors.milkCream)
              : Border.all(width: 0, color: Colors.white),
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
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RotationTransition(
                    turns: AlwaysStoppedAnimation(330 / 360),
                    child: Image(
                        image: AssetImage(tProfileCupomImage),
                        width: 25,
                        height: 25,
                        color: AppColors.berimbau),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${UtilBrasilFields.obterReal(widget.cupomView.cupomValue, moeda: true, decimal: 2)} para usar em todos os produtos',
                            style: const TextStyle(
                                color: Color.fromARGB(175, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.cupomView.cupomIsValueMin
                              ? Text(
                                  'Válido para pedidos acima de ${UtilBrasilFields.obterReal(widget.cupomView.cupomValueMin, moeda: true, decimal: 2)}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(175, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: !widget.cupomSelectedBudget ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.white,
                          side: const BorderSide(
                              width: 1, color: AppColors.berimbau),
                        ),
                        onPressed: () {
                          widget.onTap();
                        },
                        child: Text(
                          widget.textButtomSelected,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ) : const Center(child: Text("Cupom Selecionado")),
                    ),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: CustomScrollView(slivers: [
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(widget.cupomView.description),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Ver regras",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Acaba em ${DateFormat.yMd().add_jm().format(widget.cupomView.dateExpired)}',
                      style: const TextStyle(
                        color: Color.fromARGB(175, 0, 0, 0),
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
