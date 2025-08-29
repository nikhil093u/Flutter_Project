import 'package:flutter/material.dart';
import 'package:flutter_application/add_customer_form.dart';
import 'package:flutter_application/customer_info_widget.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});
  final String footerIconPath = 'assets/watericon.png';

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
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              'Customers',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: const [
              CustomerInfoWidget(
                name: 'Suresh P',
                email: 'suresh.p@example.com',
                phoneNumber: '+91 9867542301',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Srikanth',
                email: 'srikanth@example.com',
                phoneNumber: '+91 9999988888',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Suresh P',
                email: 'suresh.p@example.com',
                phoneNumber: '+91 9867542301',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Srikanth',
                email: 'srikanth@example.com',
                phoneNumber: '+91 9999988888',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Suresh P',
                email: 'suresh.p@example.com',
                phoneNumber: '+91 9867542301',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Srikanth',
                email: 'srikanth@example.com',
                phoneNumber: '+91 9999988888',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Suresh P',
                email: 'suresh.p@example.com',
                phoneNumber: '+91 9867542301',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Srikanth',
                email: 'srikanth@example.com',
                phoneNumber: '+91 9999988888',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Suresh P',
                email: 'suresh.p@example.com',
                phoneNumber: '+91 9867542301',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=150&h=150&fit=crop',
              ),
              CustomerInfoWidget(
                name: 'Srikanth',
                email: 'srikanth@example.com',
                phoneNumber: '+91 9999988888',
                profileImageUrl:
                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=150&h=150&fit=crop',
              ),
              // Add more customers here if needed
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>CustomerForm())
                  );
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.person_add),
            ),
          ),
        ],
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
