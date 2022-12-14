import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:babi_cakes_mobile/src/features/core/service/budget/budget_service.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BudgetLinearProgressComponent extends StatefulWidget {
  final BudgetView budgetView;
  const BudgetLinearProgressComponent({Key? key, required this.budgetView}) : super(key: key);

  @override
  State<BudgetLinearProgressComponent> createState() => _BudgetLinearProgressComponentState();
}

class _BudgetLinearProgressComponentState extends State<BudgetLinearProgressComponent>
    with TickerProviderStateMixin{

  late AnimationController controller1;
  late AnimationController controller2;
  late String status;

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    )..addListener(() {
      setState(() {});
    });
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    controller1.forward().orCancel;
    controller2.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.green,
                  value: controller1.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.grey3,
                  color: Colors.green,
                  value: widget.budgetView.budgetStatusEnum.type == BudgetService.awaitPayment ? controller2.value : controller1.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
            widget.budgetView.budgetStatusEnum.type == BudgetService.paidOut ?
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.grey3,
                  color: Colors.green,
                  value: widget.budgetView.budgetStatusEnum.type == BudgetService.paidOut ? controller1.value : controller2.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ): Container(),
            widget.budgetView.budgetStatusEnum.type == BudgetService.preparingOrder ||
                widget.budgetView.budgetStatusEnum.type == BudgetService.waitingForDelivery ||
                widget.budgetView.budgetStatusEnum.type == BudgetService.orderIsOutForDelivery ||
                widget.budgetView.budgetStatusEnum.type == BudgetService.orderDelivered ?
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.grey3,
                  color: Colors.green,
                  value: widget.budgetView.budgetStatusEnum.type == BudgetService.preparingOrder ||
                      widget.budgetView.budgetStatusEnum.type == BudgetService.waitingForDelivery ||
                      widget.budgetView.budgetStatusEnum.type == BudgetService.orderIsOutForDelivery ? controller2.value : controller1.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ) : Container(),
            widget.budgetView.budgetStatusEnum.type == BudgetService.orderDelivered ?
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.grey3,
                  color: Colors.green,
                  value: widget.budgetView.budgetStatusEnum.type == BudgetService.orderDelivered ? controller1.value : controller2.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
