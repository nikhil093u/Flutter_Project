// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/add_customer_category.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/features/customers/logo_overlay_screen.dart';
import 'package:flutter_application/features/customers/template_selection.dart';
import 'package:provider/provider.dart';

class AddCustomerForm extends StatefulWidget {
  final Customer? existingCustomer;
  const AddCustomerForm({super.key, this.existingCustomer});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  Uint8List?
  // ignore: unused_field
  _labelDesignPreviewBytes; 
  // ignore: unused_field
  String? _selectedTemplateId;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _modeofbusinnerController = TextEditingController();
  final _spoc1Controller = TextEditingController();
  final _spoc2Controller = TextEditingController();
  final _gstController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingCustomer != null) {
      final customer = widget.existingCustomer!;
      _nameController.text = customer.name;
      _emailController.text = customer.email;
      _phoneController.text = customer.phoneNumber;
      _addressController.text = customer.address;
      _modeofbusinnerController.text = customer.modeOfBusiness;
      _spoc1Controller.text = customer.spoc1;
      _spoc2Controller.text = customer.spoc2;
      _gstController.text = customer.gstNumber;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _modeofbusinnerController.dispose();
    _spoc1Controller.dispose();
    _spoc2Controller.dispose();
    _gstController.dispose();
    super.dispose();
  }

  void _saveCustomer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final customerProvider = Provider.of<CustomerProvider>(
      context,
      listen: false,
    );

    final newCustomer = Customer(
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      customerType: '', // Removed selection
      address: _addressController.text,
      modeOfBusiness: _modeofbusinnerController.text,
      spoc1: _spoc1Controller.text,
      spoc2: _spoc2Controller.text,
      gstNumber: _gstController.text,
    );

    if (widget.existingCustomer != null) {
      customerProvider.updateCustomer(widget.existingCustomer!, newCustomer);
    } else {
      customerProvider.addCustomer(newCustomer);
    }

    Navigator.pop(context, newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Add Customers",
          style: TextStyle(
            color: Color(0xFF030303),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  _buildTextField(
                    "Name",
                    controller: _nameController,
                    hint: "Enter Your Name",
                  ),
                  _buildTextField(
                    "Address",
                    controller: _addressController,
                    hint: "Enter Address",
                  ),
                  _buildTextField(
                    "Phone Number",
                    controller: _phoneController,
                    hint: "Enter Mobile Number",
                  ),
                  _buildTextField(
                    "Email",
                    controller: _emailController,
                    hint: "Enter Email",
                    isOptional: true,
                  ),

                  // Mode of Business Button
                  const SizedBox(height: 10),
                  Text(
                    "Mode of Business*",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCustomerCategorySelect(
                            onCategorySelected: (selectedCategory) {
                              setState(() {
                                _modeofbusinnerController.text =
                                    selectedCategory;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _modeofbusinnerController.text.isEmpty
                          ? "Select Mode of Business"
                          : _modeofbusinnerController.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Choose Label*",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    icon: Icon(Icons.label_outlined),
                    label: Text('Choose Label Design',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),),
                    onPressed: () {
                      final selectedCategory = _modeofbusinnerController.text
                          .trim();
                      if (selectedCategory.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please select Mode of Business first',
                            ),
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TemplateSelectionScreen(
                            category: selectedCategory,
                            onTemplateSelected: (template) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LogoOverlayScreen(template: template),
                                ),
                              ).then((previewData) {
                                if (previewData != null) {
                                  setState(() {
                                    _labelDesignPreviewBytes =
                                        previewData['previewBytes'];
                                    _selectedTemplateId =
                                        previewData['templateId'];
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  _buildTextField(
                    "SPOC 1 Contact Number",
                    controller: _spoc1Controller,
                    hint: "Contact Number 1",
                    isOptional: true,
                  ),
                  _buildTextField(
                    "SPOC 2 Contact Number",
                    controller: _spoc2Controller,
                    hint: "Contact Number 2",
                    isOptional: true,
                  ),
                  _buildTextField(
                    "GST Number (Compulsory for B2B)",
                    controller: _gstController,
                    hint: "Enter GST Number",
                  ),
                ],
              ),
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
            onPressed: _saveCustomer,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>((
                states,
              ) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                return Colors.blueAccent;
              }),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 14),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              shadowColor: MaterialStateProperty.all(
                Colors.black.withOpacity(0.9),
              ),
              elevation: MaterialStateProperty.all(3),
            ),
            child: const Text(
              "Save Customer",
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    String hint = '',
    bool isOptional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isOptional ? label : "$label*",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[800],
                fontFamily: 'Poppins',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (isOptional && (value == null || value.trim().isEmpty)) {
                return null;
              }

              if (!isOptional && (value == null || value.trim().isEmpty)) {
                return 'Please enter $label';
              }

              if (label == "Email" &&
                  value != null &&
                  value.trim().isNotEmpty &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }

              if ((label.contains("SPOC") || label == "Phone Number") &&
                  value != null &&
                  value.trim().isNotEmpty &&
                  !RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Enter a valid 10-digit phone number';
              }

              return null;
            },
            keyboardType: (label == "Phone Number" || label.contains("SPOC"))
                ? TextInputType.phone
                : TextInputType.text,
          ),
        ],
      ),
    );
  }
}
