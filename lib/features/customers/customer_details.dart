import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/add_newcustomer.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomerDetails extends StatefulWidget {
  final Customer initialCustomer;

  const CustomerDetails({super.key, required this.initialCustomer});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late Customer customer;

  @override
  void initState() {
    super.initState();
    customer = widget.initialCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, customer);
          },

          icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
        ),
        title: const Text(
          "Oceana Positive",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Details",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Name", customer.name),
                  const SizedBox(height: 8),
                  _infoRow("Email", customer.email),
                  const SizedBox(height: 8),
                  _infoRow("Phone", customer.phoneNumber),
                  const SizedBox(height: 8),
                  _infoRow("Customer Type", customer.customerType),
                  const SizedBox(height: 8),
                  _infoRow("Address", customer.address),
                  const SizedBox(height: 8),
                  _infoRow("Mode of Business", customer.modeOfBusiness),
                  const SizedBox(height: 8),
                  _infoRow("SPOC 1", customer.spoc1),
                  const SizedBox(height: 8),
                  _infoRow("SPOC 2", customer.spoc2),
                  const SizedBox(height: 8),
                  _infoRow("GST Number", customer.gstNumber),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Order Details",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            _orderDetailBox(
              orderId: "ORD123456",
              date: "28 Aug 2025",
              status: "Processing",
            ),

            const SizedBox(height: 24),

            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                "Follow-up calls are scheduled for next week. Discussed potential order increase for the upcoming quarter.",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              final updatedCustomer = await Navigator.push<Customer>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddCustomerForm(existingCustomer: customer),
                ),
              );

              if (updatedCustomer != null) {
                setState(() {
                  customer = updatedCustomer;
                });
              }
            },

            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color(0xFF6B9EEA); // Darker blue when pressed
                }
                return const Color(0xFFA4CDFD); // Normal color
              }),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),

            child: const Text(
              'Edit Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _orderDetailBox({
    required String orderId,
    required String date,
    required String status,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order ID: $orderId",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Date: $date",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Status: $status",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
