import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/routes/helpers/navigation_helper.dart';
import 'package:flutter_application/features/home/home.dart';
import 'resource_details.dart';
import '../customers/customers.dart';
import '../orders/orders.dart';
import '../todo/todo.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        NavigationHelper.safePush(context,Home());
        break;
      case 1:
        NavigationHelper.safePush(context,Todo());
        break;
      case 2:
        NavigationHelper.safePush(context,CustomerScreen());
        break;
      case 3:
        NavigationHelper.safePush(context,OrdersList());
        break;
      case 4:
      // NavigationHelper.safePush(context,Settings(),'/settings');
      // break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text("Oceana"),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Resources',
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: const [
            ResourceCard(
              imagePath: 'assets/resource_1.png',
              title: 'Water Filtration Product',
              description:
                  'Learn about the latest in eco-friendly water filtration technology.',
            ),
            ResourceCard(
              imagePath: 'assets/resource_2.png',
              title: 'AquaPure Marketing',
              description:
                  'Access marketing materials for the AquaPure product line.',
            ),
            ResourceCard(
              imagePath: 'assets/resource_3.png',
              title: 'Sales Guide',
              description:
                  'A comprehensive guide to selling AquaSales products.',
            ),
            ResourceCard(
              imagePath: 'assets/resource_4.png',
              title: 'Water Conservation Trends',
              description:
                  'Explore the latest trends in water conservation and sustainability.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        currentIndex: 0, // 0 means you're on the Home tab
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ResourceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResourceDetails(
              imagePath: imagePath,
              title: title,
              description: description,
            ),
          ),
        ),
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
