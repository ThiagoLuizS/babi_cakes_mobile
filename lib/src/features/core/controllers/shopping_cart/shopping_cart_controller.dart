import 'dart:collection';

import 'package:babi_cakes_mobile/src/features/core/models/cupom/cupom_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/product/product_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/shopping_cart/shopping_cart.dart';
import 'package:flutter/material.dart';

class ShoppingCartController extends ChangeNotifier {

  final List<ShoppingCart> _items = [];

  CupomView? cupomView;

  UnmodifiableListView<ShoppingCart> get items => UnmodifiableListView(_items);

  double get totalPrice => getTotalPrice();

  bool get isProductDiscount => getProductDiscount();

  double getTotalPrice() {
    double amount = 0.0;
    for (var item in _items) {
      if(item.product.existPercentage && cupomView == null) {
        amount += (item.product.value - item.product.discountValue) * item.quantity;
      } else {
        amount += item.product.value * item.quantity;
      }
    }
    return amount;
  }

  bool getProductDiscount() {
    bool discount = false;
    for (var item in _items) {
      if(item.product.existPercentage) {
        discount = true;
      }
    }
    return discount;
  }

  int getQuantityByItem(ProductView itemAdd) {
    int quantity = 0;
    for(var item in _items) {
      if(item.product.id == itemAdd.id) {
        quantity += item.quantity;
      }
    }
    return quantity;
  }

  void add(ShoppingCart itemAdd) {
    bool exist = false;
    for(var item in _items) {
      if(item.product.id == itemAdd.product.id) {
        item.quantity = item.quantity += 1;
        item.amount = item.product.value * item.quantity;
        _items[_items.indexWhere((element) => element.product.id == itemAdd.product.id)] = item;
        exist = true;
      }
    }
    if(!exist) {
      _items.add(itemAdd);
    }
    notifyListeners();
  }

  void addCupom(CupomView cupom) {
    cupomView = cupom;
    notifyListeners();
  }

  void removeCupom() {
    cupomView = null;
    notifyListeners();
  }

  void removeAll() {
    removeItems();
    removeCupom();
    notifyListeners();
  }

  void removeItems() {
    _items.clear();
  }

  void removeItem(ProductView itemProd) {
    bool removeQuantity = false;
    late ShoppingCart cart;
    for(var item in _items) {
      if(item.product.id == itemProd.id) {
        if(item.quantity > 1) {
          item.quantity = item.quantity -= 1;
          item.amount -= item.product.value;
          _items[_items.indexWhere((element) => element.product.id == itemProd.id)] = item;
          removeQuantity = true;
        }
        cart = item;
      }
    }
    if(!removeQuantity) {
      _items.remove(cart);
    }
    notifyListeners();
  }

}