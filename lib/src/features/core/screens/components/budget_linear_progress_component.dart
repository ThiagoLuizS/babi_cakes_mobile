import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BudgetLinearProgressComponent extends StatefulWidget {
  final BudgetView budgetView;
  const BudgetLinearProgressComponent({Key? key, required this.budgetView})
      : super(key: key);

  @override
  State<BudgetLinearProgressComponent> createState() =>
      _BudgetLinearProgressComponentState();
}

class _BudgetLinearProgressComponentState
    extends State<BudgetLinearProgressComponent> with TickerProviderStateMixin {
  late String status;
  late bool showStatusWait = true;
  late bool orderDelivered = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getLabelLoading(widget.budgetView.budgetStatusEnum!.type);
  }

  @override
  Widget build(BuildContext context) {
    var budgetType = widget.budgetView.budgetStatusEnum!.type;

    return showStatusWait ? Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Stack(
                children: [
                  Image(
                      image: AssetImage(orderDelivered ? tCheckImage : tClockImage),
                      width: 50,
                      height: 50,),
                  orderDelivered ? Container() : const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(child: _getLabelLoading(budgetType)),
              ),
            )
          ],
        ),
      ),
    ) : Container();
  }

  Text _getLabelLoading(budgetType) {
    var text = "";
    switch (budgetType) {
      case BudgetService.awaitPayment:
        text = "Aguardando pagamento...";
        break;
      case BudgetService.paidOut:
        text = "Aguardando a loja...";
        break;
      case BudgetService.preparingOrder:
        text = "A loja está preparando seu pedido!";
        break;
      case BudgetService.waitingForDelivery:
        text =
            "O seu pedido está pronto! Aguardando o entregador pegar o seu pedido.";
        break;
      case BudgetService.orderIsOutForDelivery:
        text = "Pedido saiu para entrega!";
        break;
      case BudgetService.orderDelivered:
        text = "Pedido entregue!";
        setState(() {
          orderDelivered = true;
        });
        break;
      case BudgetService.canceledOrder:
        text = "Pedido cancelado!";
        setState(() {
          showStatusWait = false;
        });
        break;
    }

    return Text(text);
  }
}
