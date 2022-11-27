import 'package:flutter/material.dart';

class BudgetData {

  Icon iconByStatus(String type) {
    Icon icon = const Icon(
      Icons.watch_later_outlined,
      size: 15,
      color: Colors.grey,
    );
    switch (type) {
      case 'AWAITING_PAYMENT':
        icon = const Icon(
          Icons.watch_later_outlined,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'PAID_OUT':
        icon = const Icon(
          Icons.check_circle_outline,
          size: 15,
          color: Colors.green,
        );
        break;
      case 'PREPARING_ORDER':
        icon = const Icon(
          Icons.receipt_long,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'WAITING_FOR_DELIVERY':
        icon = const Icon(
          Icons.car_crash_sharp,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'ORDER_IS_OUT_FOR_DELIVERY':
        icon = const Icon(
          Icons.car_crash_sharp,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'ORDER_DELIVERED':
        icon = const Icon(
          Icons.check_circle_outline,
          size: 15,
          color: Colors.grey,
        );
        break;
      case 'CANCELED_ORDER':
        icon = const Icon(
          Icons.cancel_outlined,
          size: 15,
          color: Colors.red,
        );
        break;
    }
    return icon;
  }

}