import 'package:flutter/material.dart';

class AddCustomerCategorySelect extends StatelessWidget {
  final Function(String) onCategorySelected;

  AddCustomerCategorySelect({super.key, required this.onCategorySelected});

  
  final List<Map<String, dynamic>> businessCategories = [
  {"id": "textile", "name": "Textile/Clothing Shop", "icon": Icons.checkroom},
  {"id": "automobile", "name": "Automobile", "icon": Icons.directions_car},
  {"id": "restaurant", "name": "Restaurant", "icon": Icons.restaurant},
  {"id": "jewelry", "name": "Jewelry", "icon": Icons.diamond},
  {"id": "real-estate", "name": "Real Estate", "icon": Icons.house},
  {"id": "software", "name": "Software Company", "icon": Icons.laptop_mac},
  {"id": "healthcare", "name": "Healthcare", "icon": Icons.local_hospital},
  {"id": "education", "name": "Education", "icon": Icons.school},
  {"id": "finance", "name": "Finance/Banking", "icon": Icons.attach_money},
  {"id": "retail", "name": "Retail/General Store", "icon": Icons.store},
  {"id": "beauty", "name": "Beauty/Salon", "icon": Icons.brush},
  {"id": "fitness", "name": "Fitness/Gym", "icon": Icons.fitness_center},
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
        title: Text('Select Business Category',
          style: TextStyle(fontFamily: 'poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: businessCategories.map((cat) {
            return GestureDetector(
              onTap: () => onCategorySelected(cat['id']),
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat['icon'], size: 40, color: Colors.blueAccent),
                    const SizedBox(height: 10),
                    Text(cat['name'], textAlign: TextAlign.center,style: TextStyle(fontFamily: 'poppins'),),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
