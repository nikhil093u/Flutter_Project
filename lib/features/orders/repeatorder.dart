import 'package:flutter/material.dart';

class RepeatOrderPage extends StatefulWidget {
  const RepeatOrderPage({super.key});

  @override
  State<RepeatOrderPage> createState() => _RepeatOrderPageState();
}

class _RepeatOrderPageState extends State<RepeatOrderPage> {
  double selectedQuantity = 1;

  final List<Map<String, dynamic>> orders = [
    {
      'orderId': '#12345',
      'quantity': 5,
      'imagePath': 'assets/images/bottle_blue.png',
    },
    {
      'orderId': '#12346',
      'quantity': 3,
      'imagePath': 'assets/images/bottle_green.png',
    },
    {
      'orderId': '#12347',
      'quantity': 2,
      'imagePath': 'assets/images/bottle_silver.png',
    },
  ];

  Widget orderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                order['imagePath'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                'Order ${order['orderId']} - ${order['quantity']} bottles',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Repeat Order',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.lightBlue.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: const Center(
                child: Text(
                  'Repeat Order',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Your Last 5 Orders',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return orderCard(orders[index]);
                },
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Quantity:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Slider(
                    value: selectedQuantity,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: selectedQuantity.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: 140,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Handle checkout
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
