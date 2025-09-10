// order_details.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/routes/routes.dart';

class OrderDetails extends StatelessWidget {
  final Order order;

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Order #${order.id.substring(0, 6)}",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              title: "Order Details",
              items: {
                'Order ID': order.id,
                'Customer Name': order.customerName,
                'Order Date': order.date.toString(),
                'Status': order.status,
              },
            ),
            _buildSection(
              title: "Bottle Customization",
              items: {
                'Water Type': order.waterType,
                'Bottle Material': order.bottleMaterial,
                'Bottle Shape': order.bottleShape,
                'Size/Quantity': order.sizeQuantity,
                'Color Combination': order.colorCombination,
                'Pre-design Option': order.preDesignOption,
                'Text on Bottle': order.textOnBottle,
              },
            ),
            _buildSection(
              title: "Social Media Details",
              items: {
                'Website URL': order.socialNetwork1,
                'Instagram/Facebook/LinkedIn': order.socialNetwork2,
              },
            ),
            _buildSection(
              title: "Order Status",
              items: {
                'Status': order.status,
              },
            ),
            _buildSection(
              title: "Quick Actions",
              customWidget: Wrap(
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
                    onPressed: () {
                      null;
                    },
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
                    onPressed: () {
                      null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    Map<String, String>? items,
    Widget? customWidget,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (items != null)
            ...items.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '${entry.key}: ${entry.value}',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                )),
          if (customWidget != null) customWidget,
        ],
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
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: color.withOpacity(0.3)),
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
