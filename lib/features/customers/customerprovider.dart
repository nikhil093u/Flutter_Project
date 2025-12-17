// Your complete CustomerProvider should look like this:

import 'package:flutter/material.dart';
import 'package:flutter_application/core/services/apiservice.dart';

class Customer {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String profileImageUrl;
  final String spoc1;
  final String spoc2;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profileImageUrl,
    required this.spoc1,
    required this.spoc2,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      name: _safeString(json['name']),
      email: _safeString(json['email']),
      phoneNumber: _safeString(json['phone']),
      address: _buildAddress(json),
      profileImageUrl: _extractImageFromComment(
        _safeString(json['comment']),
      ),
      spoc1: _safeString(json['spoc_1']),
      spoc2: _safeString(json['spoc_2']),
    );
  }

  /// Extract label image URL from HTML comment
  static String _extractImageFromComment(String? comment) {
    if (comment == null) return '';
    if (comment is bool) return '';

    final regex = RegExp(r'https?://\S+\.jpg');
    return regex.firstMatch(comment)?.group(0) ?? '';
  }
  static String _safeString(dynamic value) {
    if (value == null) return '';
    if (value is bool) return '';
    return value.toString();
  }
  static String _buildAddress(Map<String, dynamic> json) {
    final street = _safeString(json['street']);
    final city = _safeString(json['city']);

    if (street.isEmpty && city.isEmpty) return '';
    if (street.isEmpty) return city;
    if (city.isEmpty) return street;
    return '$street, $city';
  }
}


class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];
  bool isLoading = false;
  List<Customer> get customers => _customers;


  Future<void> fetchCustomers() async {
    try {
      isLoading = true;
      notifyListeners();

      _customers = await ApiService.fetchCustomers();
    } catch (e) {
      debugPrint('Customer fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  void updateCustomer(Customer oldCustomer, Customer updatedCustomer) {
    final index = _customers.indexOf(oldCustomer);
    if (index != -1) {
      _customers[index] = updatedCustomer;
      notifyListeners();
    }
  }

  void updateCustomerByPhone(String phoneNumber, Customer updatedCustomer) {
    final index = _customers.indexWhere((customer) => customer.phoneNumber == phoneNumber);
    if (index != -1) {
      _customers[index] = updatedCustomer;
      notifyListeners();
    }
  }

  void removeCustomerByPhone(String phoneNumber) {
    _customers.removeWhere((customer) => customer.phoneNumber == phoneNumber);
    notifyListeners();
  }

  Customer? getCustomerByPhone(String phoneNumber) {
    try {
      return _customers.firstWhere((customer) => customer.phoneNumber == phoneNumber);
    } catch (e) {
      return null;
    }
  }
}