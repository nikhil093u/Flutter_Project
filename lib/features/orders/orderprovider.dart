// providers/order_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_application/core/services/apiservice.dart';
import 'package:flutter_application/features/orders/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;
  bool isLoading = false;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  Order? getOrderById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }
  Future<void> fetchOrders() async {
    try {
      isLoading = true;
      notifyListeners();

      _orders = await ApiService.fetchOrders();
    } catch (e) {
      debugPrint('Order fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
