import 'package:flutter/material.dart';

class Customer {
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;

  Customer({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
  });
}

class CustomerProvider with ChangeNotifier {
  final List<Customer> _customers = [
    Customer(
      name: 'Suresh P',
      email: 'suresh.p@example.com',
      phoneNumber: '+91 9867542301',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
    ),
    Customer(
      name: 'Srikanth Reddy',
      email: 'srikanth.reddy@example.com',
      phoneNumber: '+91 9999988888',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/21.jpg',
    ),
    Customer(
      name: 'Anjali Mehta',
      email: 'anjali.mehta@example.com',
      phoneNumber: '+91 9876543210',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/45.jpg',
    ),
    Customer(
      name: 'Ravi Kumar',
      email: 'ravi.kumar@example.com',
      phoneNumber: '+91 9123456780',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/34.jpg',
    ),
    Customer(
      name: 'Deepa Shah',
      email: 'deepa.shah@example.com',
      phoneNumber: '+91 8989898989',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/52.jpg',
    ),
    Customer(
      name: 'Aman Verma',
      email: 'aman.verma@example.com',
      phoneNumber: '+91 9090909090',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/55.jpg',
    ),
    Customer(
      name: 'Priya Desai',
      email: 'priya.desai@example.com',
      phoneNumber: '+91 9001234567',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/61.jpg',
    ),
    Customer(
      name: 'Nikhil Sharma',
      email: 'nikhil.sharma@example.com',
      phoneNumber: '+91 9988776655',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/41.jpg',
    ),
    Customer(
      name: 'Kavita Joshi',
      email: 'kavita.joshi@example.com',
      phoneNumber: '+91 9876501234',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/30.jpg',
    ),
    Customer(
      name: 'Arjun Singh',
      email: 'arjun.singh@example.com',
      phoneNumber: '+91 9012345678',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/19.jpg',
    ),
    Customer(
      name: 'Meena Kumari',
      email: 'meena.kumari@example.com',
      phoneNumber: '+91 9100001122',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/14.jpg',
    ),
    Customer(
      name: 'Rahul Dev',
      email: 'rahul.dev@example.com',
      phoneNumber: '+91 9301234567',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/64.jpg',
    ),
    Customer(
      name: 'Sneha Patel',
      email: 'sneha.patel@example.com',
      phoneNumber: '+91 9445566778',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/66.jpg',
    ),
    Customer(
      name: 'Manoj Tiwari',
      email: 'manoj.tiwari@example.com',
      phoneNumber: '+91 9800112233',
      profileImageUrl: 'https://randomuser.me/api/portraits/men/23.jpg',
    ),
    Customer(
      name: 'Divya Agarwal',
      email: 'divya.agarwal@example.com',
      phoneNumber: '+91 9900887766',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/88.jpg',
    ),
  ];

  List<Customer> get customers => _customers;

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }
}
