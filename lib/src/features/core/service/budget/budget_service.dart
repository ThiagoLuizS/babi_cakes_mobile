import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_body_send.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserverd_form.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/shopping_cart/shopping_cart.dart';

class BudgetService {

  static String awaitPayment = "AWAITING_PAYMENT";
  static String paidOut = "PAID_OUT";
  static String orderDelivered = "ORDER_DELIVERED";
  static String preparingOrder = "PREPARING_ORDER";
  static String waitingForDelivery = "WAITING_FOR_DELIVERY";
  static String orderIsOutForDelivery = "ORDER_IS_OUT_FOR_DELIVERY";


  static BudgetBodySend createOrderForSend(List<ShoppingCart> list, CupomView? cupomView) {
    BudgetBodySend budgetBodySend = BudgetBodySend(listItems: [], cupomCode: cupomView != null ? cupomView.code : '');
    for (var cart in list) {
      budgetBodySend.listItems.add(BudgetProductReservedForm(productCode: cart.product.code, quantity: cart.quantity));
    }
    return budgetBodySend;
  }

  static String getStatusPayment(String status) {
    switch (status) {
      case 'AWAITING_PAYMENT':
        return awaitPayment;
      case 'PAID_OUT':
        return paidOut;
      case 'ORDER_DELIVERED':
        return orderDelivered;
      default:
        return "";
    }
  }
}