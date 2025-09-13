import 'package:flutter/material.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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

  final List<String> labels = const [
    'Customers',
    'Orders',
    'Resources',
    'To-Do\'s',
  ];

  final List<IconData> icons = const [
    LucideIcons.users,
    LucideIcons.shoppingCart,
    LucideIcons.refreshCcw,
    LucideIcons.listTodo,
  ];

  Widget _buildClickableBlock(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        if (label == 'Customers') {
          Navigator.pushNamed(context, Routes.customers);
        } else if (label == 'Orders') {
          Navigator.pushNamed(context, Routes.orders);
        } else if (label == 'Resources') {
          Navigator.pushNamed(context, Routes.resources);
        } else if (label == 'To-Do\'s') {
           Navigator.pushNamed(context, Routes.todo);
        }
      },
      child: Container(
        width: 135,
        height: 135,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF030303),
                fontSize: 20,
                fontFamily: 'Poppins',
                height: 26 / 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.menu,
            size: 24,
            color: Color(0xFF030303),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.profile);
          },
        ),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.todo);
          },
          child: const Text(
            'Sales Application',
            style: TextStyle(
              color: Color(0xFF030303),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 29),
            Center(
              child: Container(
                width: 215,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/logo/logo.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                DateFormat('hh:mm a').format(DateTime.now()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 56,
                  height: 73 / 56,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                DateFormat('dd.MM.yyyy').format(DateTime.now()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 20,
                  height: 26 / 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4CDFD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 42),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[0],
                              icons[0],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[1],
                              icons[1],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 42),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[2],
                              icons[2],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[3],
                              icons[3],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        currentIndex: 0,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
