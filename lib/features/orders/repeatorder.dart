import 'package:flutter/material.dart';
import 'package:flutter_application/features/orders/order_model.dart';

class RepeatOrderPage extends StatefulWidget {
  final Order order;

  const RepeatOrderPage({super.key, required this.order});

  @override
  State<RepeatOrderPage> createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Repeat Order',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 💡 Order Summary Card with Shadow
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow("Customer", order.customerName),
                    _buildDetailRow("Water Type", order.waterType),
                    _buildDetailRow("Material", order.bottleMaterial),
                    _buildDetailRow("Shape", order.bottleShape),
                    _buildDetailRow("Color", order.colorCombination),
                    _buildDetailRow("Text on Bottle", order.textOnBottle),
                    _buildDetailRow("Pre-design", order.preDesignOption),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🧮 Quantity Selector Styled Like Image
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            color: Colors.blueAccent),
                        SizedBox(width: 6),
                        Text(
                          "Select the quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: selectedQuantity > 1
                                  ? () {
                                      setState(() {
                                        selectedQuantity--;
                                      });
                                    }
                                  : null,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  selectedQuantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  selectedQuantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Checkout and Proceed Buttons like Image
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCCE5FF), Color(0xFFCCE5FF)],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Check out & Pay",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Simulate checkout
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Proceeding with $selectedQuantity bottles'),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Proceed to Payment",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}
