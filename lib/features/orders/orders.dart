import 'package:flutter/material.dart';
// import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/features/orders/orderprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/footer.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  String _searchQuery = '';

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
    final orderProvider = Provider.of<OrderProvider>(context);
    final allOrders = orderProvider.orders;

    final filteredOrders = allOrders.where((order) {
      final name = order.customerName.toLowerCase();
      final id = order.id.toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          id.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, size: 24, color: Color(0xFF030303)),
          onPressed: () {},
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
              'Orders',
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
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Orders...',
                hintStyle: const TextStyle(fontFamily: 'Poppins'),
                prefixIcon: const Icon(LucideIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(
                    child: Text(
                      'No orders found',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      final formattedDate =
                          DateFormat('dd MMM yyyy').format(order.date);

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.orderdetails,
                            arguments: order,
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order ID: ${order.id}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        order.customerName,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins'),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA4CDFD),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createorder);
        },
        backgroundColor: Colors.white,
        child: const Icon(LucideIcons.plus, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Footer(
        currentIndex: 3,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
