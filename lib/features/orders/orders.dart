import 'package:flutter/material.dart';
import 'package:flutter_application/routes/helpers/navigation_helper.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../common/widgets/footer.dart';
import 'order_details.dart';
import '../home/home.dart';
import '../todo/todo.dart';
import '../customers/customers.dart';
import 'create_order.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        NavigationHelper.safePush(context, Home());
        break;
      case 1:
        NavigationHelper.safePush(context, Todo());
        break;
      case 2:
        NavigationHelper.safePush(context, CustomerScreen());
        break;
      case 3:
        NavigationHelper.safePush(context, OrdersList());
        break;
      case 4:
      // NavigationHelper.safePush(context,Settings(),'/settings');
      // break;
    }
  }

  final List<Map<String, String>> _orders = [
  {
    'id': 'ORD12345',
    'name': 'Alice Johnson',
    'date': 'Aug 20, 2025',
    'status': 'Shipped',
  },
  {
    'id': 'ORD12346',
    'name': 'Bob Smith',
    'date': 'Aug 21, 2025',
    'status': 'Delivered',
  },
  {
    'id': 'ORD12347',
    'name': 'Charlie Lee',
    'date': 'Aug 22, 2025',
    'status': 'Processing',
  },
  {
    'id': 'ORD12348',
    'name': 'Diana Prince',
    'date': 'Aug 23, 2025',
    'status': 'Shipped',
  },
  {
    'id': 'ORD12349',
    'name': 'Ethan Hunt',
    'date': 'Aug 24, 2025',
    'status': 'Cancelled',
  },
  {
    'id': 'ORD12350',
    'name': 'Fiona Gallagher',
    'date': 'Aug 25, 2025',
    'status': 'Delivered',
  },
  {
    'id': 'ORD12351',
    'name': 'George Clooney',
    'date': 'Aug 26, 2025',
    'status': 'Processing',
  },
  {
    'id': 'ORD12352',
    'name': 'Hannah Baker',
    'date': 'Aug 27, 2025',
    'status': 'Shipped',
  },
  {
    'id': 'ORD12353',
    'name': 'Isaac Newton',
    'date': 'Aug 28, 2025',
    'status': 'Delivered',
  },
  {
    'id': 'ORD12354',
    'name': 'Jack Sparrow',
    'date': 'Aug 29, 2025',
    'status': 'Processing',
  },
  {
    'id': 'ORD12355',
    'name': 'Katherine Langford',
    'date': 'Aug 30, 2025',
    'status': 'Cancelled',
  },
  {
    'id': 'ORD12356',
    'name': 'Leo Messi',
    'date': 'Aug 31, 2025',
    'status': 'Delivered',
  },
  {
    'id': 'ORD12357',
    'name': 'Mona Lisa',
    'date': 'Sep 01, 2025',
    'status': 'Shipped',
  },
  {
    'id': 'ORD12358',
    'name': 'Nina Dobrev',
    'date': 'Sep 02, 2025',
    'status': 'Processing',
  },
  {
    'id': 'ORD12359',
    'name': 'Oscar Isaac',
    'date': 'Sep 03, 2025',
    'status': 'Delivered',
  },
];


  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _orders.where((order) {
      final name = order['name']!.toLowerCase();
      final id = order['id']!.toLowerCase();
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
              style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w600, fontSize: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetails(order: order),
                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: ${order['id']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(order['name'] ?? ''),
                                const SizedBox(height: 4),
                                Text(
                                  order['date'] ?? '',
                                  style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
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
                              order['status'] ?? '',
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateOrder()),
          );
        },
        backgroundColor: Colors.white,
        child: Icon(LucideIcons.plus,color: Colors.black,),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Footer(
        currentIndex: 3,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
