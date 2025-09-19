import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/features/orders/orderprovider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final _formKey = GlobalKey<FormState>();

  String? waterType = 'Mineral Water';
  String? bottleMaterial = 'Plastic';
  String? bottleShape = 'Round';
  String? sizeQuantity = '500ml';
  String? colorCombination = 'Blue & White';
  String? preDesignOption = 'Modern';
  String? selectedFileName;
  String? selectedPredefinedLogo;

  final TextEditingController textOnBottleController = TextEditingController();
  final TextEditingController socialNetwork1Controller = TextEditingController();
  final TextEditingController socialNetwork2Controller = TextEditingController();

   final List<String> predefinedLogos = [
    'assets/logo/logo1.1.png',
    'assets/logo/logo1.2.png',
    'assets/logo/logo1.3.png',
    'assets/logo/logo1.4.png',
  ];

  final List<String> waterTypeOptions = ['Mineral Water', 'Spring Water', 'Distilled Water'];
  final List<String> bottleMaterialOptions = ['Plastic', 'Glass', 'Metal'];
  final List<String> bottleShapeOptions = ['Round', 'Square', 'Oval'];
  final List<String> sizeQuantityOptions = ['250ml', '500ml', '1L'];
  final List<String> colorCombinationOptions = ['Blue & White', 'Red & White', 'Green & White'];
  final List<String> preDesignOptions = ['Modern', 'Classic', 'Minimal'];

  @override
  void initState() {
    super.initState();
    textOnBottleController.addListener(() {
      if (selectedPredefinedLogo != null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    textOnBottleController.dispose();
    socialNetwork1Controller.dispose();
    socialNetwork2Controller.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    final newOrder = Order(
      id: const Uuid().v4().substring(0, 8),
      customerName: currentUser?.firstName ?? '',
      date: DateTime.now(),
      status: 'Pending',
      waterType: waterType!,
      bottleMaterial: bottleMaterial!,
      bottleShape: bottleShape!,
      sizeQuantity: sizeQuantity!,
      colorCombination: colorCombination!,
      preDesignOption: preDesignOption!,
      textOnBottle: textOnBottleController.text,
      socialNetwork1: socialNetwork1Controller.text,
      socialNetwork2: socialNetwork2Controller.text,
      logoPath: selectedPredefinedLogo ?? selectedFileName,
    );

    Provider.of<OrderProvider>(context, listen: false).addOrder(newOrder);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropdownField(
                  label: 'Select Water Type',
                  value: waterType,
                  items: waterTypeOptions,
                  onChanged: (value) => setState(() => waterType = value),
                ),
                buildDropdownField(
                  label: 'Select Bottle Material Type',
                  value: bottleMaterial,
                  items: bottleMaterialOptions,
                  onChanged: (value) => setState(() => bottleMaterial = value),
                ),
                buildDropdownField(
                  label: 'Select Bottle Shape',
                  value: bottleShape,
                  items: bottleShapeOptions,
                  onChanged: (value) => setState(() => bottleShape = value),
                ),
                buildDropdownField(
                  label: 'Select the Size/Quantity',
                  value: sizeQuantity,
                  items: sizeQuantityOptions,
                  onChanged: (value) => setState(() => sizeQuantity = value),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Existing Logos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: predefinedLogos.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final logo = predefinedLogos[index];
                      final isSelected = selectedPredefinedLogo == logo;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPredefinedLogo = logo;
                            selectedFileName = null; // Clear file
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.blueAccent : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(logo),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
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
                      setState(() {
                        selectedFileName = 'user_logo.pdf'; // Stubbed
                        selectedPredefinedLogo = null; // Clear predefined
                      });
                    },
                    child: Text(
                      selectedFileName == null ? 'Choose File' : selectedFileName!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),

                // === PREVIEW WITH TEXT OVERLAY ===
                if (selectedPredefinedLogo != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              selectedPredefinedLogo!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            textOnBottleController.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),
                buildDropdownField(
                  label: 'Select Colour Combination',
                  value: colorCombination,
                  items: colorCombinationOptions,
                  onChanged: (value) => setState(() => colorCombination = value),
                ),
                buildValidatedTextField(
                  label: 'Enter the Text on Bottle',
                  controller: textOnBottleController,
                  hint: 'Enter text here',
                ),
                buildDropdownField(
                  label: 'Select Pre-design Options',
                  value: preDesignOption,
                  items: preDesignOptions,
                  onChanged: (value) => setState(() => preDesignOption = value),
                ),
                buildValidatedTextField(
                  label: 'Add Social Network Details:',
                  controller: socialNetwork1Controller,
                  hint: 'Website URL',
                ),
                buildValidatedTextField(
                  label: '',
                  controller: socialNetwork2Controller,
                  hint: 'Instagram/Facebook/LinkedIn',
                ),
              ],
            ),
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
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              elevation: WidgetStateProperty.all(3),
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
        ),
      ),
    );
  }

  Widget buildDropdownField({
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
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Poppins')),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              fillColor: Colors.white,
              filled: true,
            ),
            items: items
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e,
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins', color: Colors.grey[800])),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
          ),
        ],
      ),
    );
  }

  Widget buildValidatedTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Poppins')),
          if (label.isNotEmpty) const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD5D5DA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFA4CDFD)),
              ),
            ),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'This field is required' : null,
          ),
        ],
      ),
    );
  }
}
