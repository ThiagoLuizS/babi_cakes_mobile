import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/budget/budget_provider_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/charge/charge_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/charge/charge.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PixPaymentButtonComponent extends StatefulWidget {
  final BudgetView budgetView;
  final String value;

  const PixPaymentButtonComponent({Key? key, required this.budgetView, this.value = ""})
      : super(key: key);

  @override
  State<PixPaymentButtonComponent> createState() =>
      _PixPaymentButtonComponentState();
}

class _PixPaymentButtonComponentState extends State<PixPaymentButtonComponent> {
  late bool isDurationMessaCopy = false;
  final ChargeBloc _blocCharge = ChargeBloc();
  late Charge charge;
  late bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _createImmediateCharge();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<BudgetProviderController>(
        builder: (ctx, cart, child) {
          return !isLoading ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  showBarModalBottomSheet<void>(
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
                                                    Stack(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(tCheckImage),
                                                            width: 155,
                                                            height: 155,
                                                            color: Color.fromARGB(
                                                                108, 23, 175, 23)
                                                        ),
                                                        SizedBox(
                                                          width: 155,
                                                          height: 155,
                                                          child: CircularProgressIndicator(color: Colors.green,),
                                                        )
                                                      ],
                                                    ),
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
                                                    Row(
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
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 2),
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
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.milkCream,
                  side: const BorderSide(width: 0, color: Colors.white),
                ),
                child: const Text(
                  "Fazer pedido",
                  style: TextStyle(color: Colors.black),
                )),
          ) : const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  color: AppColors.berimbau),
            ),
          );
        });

  }

  _createImmediateCharge() async {
    if(widget.budgetView.budgetStatusEnum.type == BudgetService.awaitPayment) {
      setState(() {
        isLoading = true;
      });
      ApiResponse<Charge> response =
      await _blocCharge.createImmediateCharge(widget.budgetView.id);

      if (response.ok) {
        setState(() {
          charge = response.result;
        });
      } else {
        alertToast(context, response.erros[0].toString(), 8, Colors.grey, false);
      }

      setState(() {
        isLoading = false;
      });
    }

  }
}
