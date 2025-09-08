import 'package:flutter/material.dart';
import 'package:flutter_application/core/services/apiservice.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../common/widgets/footer.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<Order> _orders = [];
  final List<Order> _dummyOrders = [
    Order(
      id: 'ORD001',
      name: 'Water Bottle Pack',
      date: '2023-09-01',
      status: 'Delivered',
    ),
    Order(
      id: 'ORD002',
      name: 'Eco-friendly Straws',
      date: '2023-09-05',
      status: 'Pending',
    ),
    Order(
      id: 'ORD003',
      name: 'Reusable Bags',
      date: '2023-09-10',
      status: 'Shipped',
    ),
    Order(
      id: 'ORD004',
      name: 'Water Filter',
      date: '2023-09-12',
      status: 'Cancelled',
    ),
    Order(
      id: 'ORD005',
      name: 'Solar Charger',
      date: '2023-09-15',
      status: 'Delivered',
    ),
  ];

  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    try {
      final fetchedOrders = await ApiService.fetchOrders();
      setState(() {
        _orders = fetchedOrders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _orders = _dummyOrders;
        _isLoading = false;
      });
      print('Error fetching orders: $e');
    }
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
    final filteredOrders = _orders.where((order) {
      final name = order.name.toLowerCase();
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
          icon: const Icon(Icons.menu, size: 24, color: Color(0xFF030303)),
          onPressed: () {},
        ),
        title: Row(
          children: const [
            Text(
              'Oceana',
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Orders...',
                      hintStyle: TextStyle(fontFamily: 'Poppins'),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
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
                                      Text(order.name),
                                      const SizedBox(height: 4),
                                      Text(
                                        order.date,
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
        child: Icon(LucideIcons.plus, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Footer(
        currentIndex: 3,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
