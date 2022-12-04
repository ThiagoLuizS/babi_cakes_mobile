import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_body_send.dart';
import 'package:babi_cakes_mobile/src/features/core/models/budget/budget_product_reserverd_form.dart';
import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/shopping_cart/shopping_cart.dart';

class BudgetService {

  static BudgetBodySend createOrderForSend(List<ShoppingCart> list, CupomView? cupomView) {
    BudgetBodySend budgetBodySend = BudgetBodySend(listItems: [], cupomCode: cupomView != null ? cupomView.code : '');
    for (var cart in list) {
      budgetBodySend.listItems.add(BudgetProductReservedForm(productCode: cart.product.code, quantity: cart.quantity));
    }
    return budgetBodySend;
  }
}