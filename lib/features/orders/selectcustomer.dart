import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:provider/provider.dart';

class SelectCustomer extends StatelessWidget {
  const SelectCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final allCustomers = customerProvider.customers;
    final int customerCountToShow = allCustomers.length >= 2
        ? 2
        : allCustomers.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Oceana",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: const [
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Text(
                "Create Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Select Customer",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField("Search Customer"),
            const SizedBox(height: 12),
            allCustomers.isEmpty
                ? const Text(
                    "No customers available.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  )
                : Column(
                    children: List.generate(customerCountToShow, (index) {
                      final customer = allCustomers[index];
                      return Column(
                        children: [
                          _buildCustomerCard(
                            customer.name,
                            customer.phoneNumber,
                            customer.email,
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),
                  ),

            const SizedBox(height: 24),
            const Text(
              "Create New Customer",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField("Customer Name"),
            const SizedBox(height: 12),
            _buildTextField("Contact Email"),
            const SizedBox(height: 12),
            _buildTextField("Address"),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createorder);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: const TextStyle(fontFamily: 'Poppins'),
    );
  }

  Widget _buildCustomerCard(String name, String phone, String email) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phone,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
        ],
      ),
    );
  }
}
