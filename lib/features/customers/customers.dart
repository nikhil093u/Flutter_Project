import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customer_info_widget.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/routes/routes.dart';

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

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final List<Customer> allCustomers = [
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

  List<Customer> filteredCustomers = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredCustomers = allCustomers;
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredCustomers = allCustomers.where((customer) {
        return customer.name.toLowerCase().contains(searchQuery) ||
            customer.phoneNumber.contains(searchQuery);
      }).toList();
    });
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.home);

        break;
      case 1:
        Navigator.pushNamed(context, Routes.todo);

        break;
      case 2:
        Navigator.pushNamed(context, Routes.customers);

        break;
      case 3:
        Navigator.pushNamed(context, Routes.orders);

        break;
      case 4:
        Navigator.pushNamed(context, Routes.setting);
       break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 24, color: Color(0xFF030303)),
          onPressed: () {},
        ),
        title: Row(
          children: [
            const Text(
              'Oceana',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: _onSearchChanged,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  hintText: 'Search by name or number',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: filteredCustomers.length,
            itemBuilder: (context, index) {
              final customer = filteredCustomers[index];
              return CustomerInfoWidget(
                name: customer.name,
                email: customer.email,
                phoneNumber: customer.phoneNumber,
                profileImageUrl: customer.profileImageUrl,
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.addcustomer);
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.person_add, color: Colors.black),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Footer(
        currentIndex: 2,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
