import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/labeldesigner.dart';
import 'package:flutter_application/features/customers/sizeselection.dart';
import 'package:flutter_application/features/customers/selectcategory.dart';

class AddNewcustomer extends StatefulWidget {
  const AddNewcustomer({super.key});

  @override
  State<AddNewcustomer> createState() => _AddNewcustomerState();  
}

class _AddNewcustomerState extends State<AddNewcustomer> {
  String step = 'size';
  String selectedSize = '';
  String sizeDescription = '';
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: const Text('Label Designer', style: TextStyle(fontFamily: 'Poppins'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildCurrentStep(),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (step) {
      case 'size':
        return SizeSelection(
          onSizeSelect: (size) {
            setState(() {
              selectedSize = size;
              step = 'category';
            });
          },
          sizeDescription: (desc) {
            setState(() => sizeDescription = desc);
          },
        );

      case 'category':
        return CategorySelection(
          // onBack: () => setState(() => step = 'size'),
          onCategorySelect: (categoryId) {
            setState(() {
              selectedCategory = categoryId;
              step = 'design';
            });
          },
        );

      case 'design':
        return LabelDesigner(
          labelSize: selectedSize,
          labelDescription: sizeDescription,
          category: selectedCategory,
        );

      default:
        return const SizedBox();
    }
  }
}