import 'package:flutter/material.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  String? waterType = 'Mineral Water';
  String? bottleMaterial = 'Plastic';
  String? bottleShape = 'Round';
  String? sizeQuantity = '500ml';
  String? colorCombination = 'Blue & White';
  String? preDesignOption = 'Modern';

  final TextEditingController textOnBottleController = TextEditingController();
  final TextEditingController socialNetwork1Controller = TextEditingController();
  final TextEditingController socialNetwork2Controller = TextEditingController();

  final List<String> waterTypeOptions = ['Mineral Water', 'Spring Water', 'Distilled Water'];
  final List<String> bottleMaterialOptions = ['Plastic', 'Glass', 'Metal'];
  final List<String> bottleShapeOptions = ['Round', 'Square', 'Oval'];
  final List<String> sizeQuantityOptions = ['250ml', '500ml', '1L'];
  final List<String> colorCombinationOptions = ['Blue & White', 'Red & White', 'Green & White'];
  final List<String> preDesignOptions = ['Modern', 'Classic', 'Minimal'];

  void _submitOrder() {
    if (waterType == null ||
        bottleMaterial == null ||
        bottleShape == null ||
        sizeQuantity == null ||
        colorCombination == null ||
        preDesignOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields',style: TextStyle(fontFamily: 'Poppins'))),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order submitted successfully!',style: TextStyle(fontFamily: 'Poppins'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(
                label: 'Select Water Type',
                value: waterType,
                items: waterTypeOptions,
                onChanged: (value) => setState(() => waterType = value),
              ),
              buildDropdown(
                label: 'Select Bottle Material Type',
                value: bottleMaterial,
                items: bottleMaterialOptions,
                onChanged: (value) => setState(() => bottleMaterial = value),
              ),
              buildDropdown(
                label: 'Select Bottle Shape',
                value: bottleShape,
                items: bottleShapeOptions,
                onChanged: (value) => setState(() => bottleShape = value),
              ),
              buildDropdown(
                label: 'Select the Size/Quantity',
                value: sizeQuantity,
                items: sizeQuantityOptions,
                onChanged: (value) => setState(() => sizeQuantity = value),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload a Logo (Allowed formats .PSD, .AI, .CDR, PDF)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(color: const Color(0xFFD5D5DA)),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    null;
                  },
                  child: Text(
                    'Choose File',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey[800]
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildDropdown(
                label: 'Select Colour Combination',
                value: colorCombination,
                items: colorCombinationOptions,
                onChanged: (value) => setState(() => colorCombination = value),
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Enter the Text on Bottle',
                controller: textOnBottleController,
                hint: 'Enter text here',
              ),
              const SizedBox(height: 16),
              buildDropdown(
                label: 'Select Pre-design Options',
                value: preDesignOption,
                items: preDesignOptions,
                onChanged: (value) => setState(() => preDesignOption = value),
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Add Social Network Details:',
                controller: socialNetwork1Controller,
                hint: 'Website URL',
              ),
  
              const SizedBox(height: 8),
              buildTextField(
                label: '',
                controller: socialNetwork2Controller,
                hint: 'Instagram/Facebook/LinkedIn',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _submitOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA4CDFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Submit Order',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      )
    )
    );
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD5D5DA)),
              color: Colors.white,
            ),
            child: DropdownButtonFormField<String>(
              initialValue: value,
              isExpanded: true,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              items: items
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color:Colors.grey[800],
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
              iconEnabledColor: Colors.black,
              dropdownColor: Colors.white,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
                        hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[800],fontFamily: 'Poppins'),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD5D5DA)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD5D5DA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFA4CDFD)),
            ),
          ),
        ),
      ],
    );
  }
}

