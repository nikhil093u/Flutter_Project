import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;

  const CustomerDetails({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Oceana",
          style: TextStyle(color: Colors.black,fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Details",
              style: TextStyle(fontSize: 20,fontFamily: 'Poppins', fontWeight: FontWeight.bold),
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
                  _infoRow("Name", name),
                  const SizedBox(height: 8),
                  _infoRow("Email", email),
                  const SizedBox(height: 8),
                  _infoRow("Phone", phoneNumber),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Order Details",
              style: TextStyle(fontSize: 18,fontFamily: 'Poppins', fontWeight: FontWeight.w600),
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
              style: TextStyle(fontSize: 18,fontFamily: 'Poppins', fontWeight: FontWeight.w600),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA4CDFD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
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
          style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins', fontSize: 16),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16))),
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
            style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            "Date: $date",
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black54),
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
