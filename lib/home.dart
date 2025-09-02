import 'package:flutter/material.dart';
import 'customers.dart';
import 'orders.dart';
import 'resource.dart';
import 'todo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final List<String> labels = const [
    'Customers',
    'Orders',
    'Resources',
    'Help',
  ];
  final List<String> iconPaths = const [
    'assets/customers.png',
    'assets/orders.png',
    'assets/resources.png',
    'assets/help.png',
  ];

  final String footerIconPath = 'assets/watericon.png';

  Widget _buildClickableBlock(
    BuildContext context,
    String label,
    String iconPath,
  ) {
    return GestureDetector(
      onTap: () {
        if (label == 'Customers') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerScreen()),
          );
        }
        if (label == 'Orders') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrdersList()),
          );
        }
        if(label== 'Resources'){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=> ResourcePage()),
          );
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
            Image.asset(iconPath, width: 48, height: 48, fit: BoxFit.contain),
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

  Widget _buildFooterItem(String label) {
    return GestureDetector(
      onTap: () {
        // Placeholder for footer navigation
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            footerIconPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF030303),
              fontFamily: 'Poppins',
            ),
          ),
        ],
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
          icon: const Icon(Icons.menu, size: 24, color: Color(0xFF030303)),
          onPressed: () {
            null;
          },
        ),
        title: GestureDetector(
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Todo())
            );
          },
          child:  Text(
          'To-Do List',
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
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Center(
              child: Text(
                '09:11 AM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 56,
                  height: 73 / 56,
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            const SizedBox(height: 2),

            const Center(
              child: Text(
                '08-22-2025',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                  borderRadius: BorderRadius.circular(12),
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
                              iconPaths[0],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[1],
                              iconPaths[1],
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
                              iconPaths[2],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildClickableBlock(
                              context,
                              labels[3],
                              iconPaths[3],
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

      bottomNavigationBar: Container(
        width: 375,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(3, 3, 3, 0.1),
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFooterItem('Home'),
            _buildFooterItem('Resources'),
            _buildFooterItem('Training'),
            _buildFooterItem('Team'),
          ],
        ),
      ),
    );
  }
}
