import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({super.key});

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
        Navigator.pushNamed(context, Routes.home);

        break;
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
                Text(
                  "Oceana Positive",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                        Icon(LucideIcons.search, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Resources',
                              hintStyle: TextStyle(fontFamily: 'Poppins'),
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
              imagePath: 'assets/images/resource_1.png',
              title: 'Water Filtration Process',
              description:
                  'Learn about the latest in eco-friendly water filtration technology.',
            ),
            ResourceCard(
              imagePath: 'assets/images/resource_2.png',
              title: 'AquaPure Marketing',
              description:
                  'Access marketing materials for the AquaPure product line.',
            ),
            ResourceCard(
              imagePath: 'assets/images/resource_3.png',
              title: 'Sales Guide',
              description:
                  'A comprehensive guide to selling AquaSales products.',
            ),
            ResourceCard(
              imagePath: 'assets/images/resource_4.png',
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
      onTap: () {
        Navigator.pushNamed(
          context,
          '/resourcedetails',
          arguments: {
            'imagePath': imagePath,
            'title': title,
            'description': description,
          },
        );
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
