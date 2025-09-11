// Your complete CustomerProvider should look like this:

import 'package:flutter/material.dart';

class Customer {
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final String customerType;
  final String address;
  final String modeOfBusiness;
  final String spoc1;
  final String spoc2;
  final String gstNumber;

  Customer({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.customerType,
    required this.address,
    required this.modeOfBusiness,
    required this.spoc1,
    required this.spoc2,
    required this.gstNumber,
  });

  Customer copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? customerType,
    String? address,
    String? modeOfBusiness,
    String? spoc1,
    String? spoc2,
    String? gstNumber,
  }) {
    return Customer(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      customerType: customerType ?? this.customerType,
      address: address ?? this.address,
      modeOfBusiness: modeOfBusiness ?? this.modeOfBusiness,
      spoc1: spoc1 ?? this.spoc1,
      spoc2: spoc2 ?? this.spoc2,
      gstNumber: gstNumber ?? this.gstNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Customer &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl &&
        other.customerType == customerType &&
        other.address == address &&
        other.modeOfBusiness == modeOfBusiness &&
        other.spoc1 == spoc1 &&
        other.spoc2 == spoc2 &&
        other.gstNumber == gstNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profileImageUrl.hashCode ^
        customerType.hashCode ^
        address.hashCode ^
        modeOfBusiness.hashCode ^
        spoc1.hashCode ^
        spoc2.hashCode ^
        gstNumber.hashCode;
  }
}

class CustomerProvider with ChangeNotifier {
  final List<Customer> _customers = [];

  List<Customer> get customers => _customers;

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