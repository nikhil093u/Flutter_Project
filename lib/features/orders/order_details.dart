// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/routes/routes.dart';

class OrderDetails extends StatelessWidget {
  final Map<String, String> order;

  const OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Order #${order['id']}",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Order ID: ${order['id']}',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Customer Name: ${order['name']}',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Order Date: ${order['date']}',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${order['status']}',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Name: ${order['name']}',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${order['name']}@gmail.com',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Phone Number: +91 9999999999',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Address: New York',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Status",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Status: ${order['status']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions container (new)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _actionButton(
                        context: context,
                        label: "Repeat Order",
                        icon: Icons.replay_outlined,
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.repeatorder);
                        },
                      ),
                      _actionButton(
                        context: context,
                        label: "Generate Invoice",
                        icon: Icons.receipt_long_outlined,
                        color: Colors.orange,
                        onPressed: () {},
                      ),
                      _actionButton(
                        context: context,
                        label: "New Order",
                        icon: Icons.add_shopping_cart_outlined,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.createorder);
                        },
                      ),
                      _actionButton(
                        context: context,
                        label: "Need Assistance",
                        icon: Icons.support_agent_outlined,
                        color: Colors.purple,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
        style:
            ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.1),
              foregroundColor: color,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: color.withOpacity(0.3)),
              ),
              shadowColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ).copyWith(
              overlayColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(0.5),
              ),
            ),
      ),
    );
  }
}