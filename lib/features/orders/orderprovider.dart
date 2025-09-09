// providers/order_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_application/features/orders/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  Order? getOrderById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }
}
