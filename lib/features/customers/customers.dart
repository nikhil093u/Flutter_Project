import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customer_info_widget.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
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
    final customerProvider = Provider.of<CustomerProvider>(context);
    final allCustomers = customerProvider.customers;

    final displayedCustomers = searchQuery.isEmpty
        ? allCustomers
        : allCustomers.where((customer) {
            return customer.name.toLowerCase().contains(searchQuery) ||
                customer.phoneNumber.contains(searchQuery);
          }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            size: 24,
            color: Color(0xFF030303),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: const [
            Text(
              'Oceana Positive',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              'Customers',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: _onSearchChanged,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search by name or number',
                hintStyle: const TextStyle(fontFamily: 'Poppins'),
                prefixIcon: const Icon(LucideIcons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: displayedCustomers.isEmpty
                ? const Center(
                    child: Text(
                      'No customers found',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: displayedCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = displayedCustomers[index];
                      return CustomerInfoWidget(customer: customer);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addcustomer);
        },
        backgroundColor: Colors.white,
        child: const Icon(LucideIcons.userPlus2, size: 30, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Footer(
        currentIndex: 2,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
