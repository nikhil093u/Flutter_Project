// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:provider/provider.dart';

class AddCustomerForm extends StatefulWidget {
  final Customer? existingCustomer;
  const AddCustomerForm({super.key, this.existingCustomer});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _modeofbusinnerController = TextEditingController();
  final _spoc1Controller = TextEditingController();
  final _spoc2Controller = TextEditingController();
  final _gstController = TextEditingController();

  String? _selectedCustomerType;

  @override
  void initState() {
    super.initState();

    if (widget.existingCustomer != null) {
      final customer = widget.existingCustomer!;
      _nameController.text = customer.name;
      _emailController.text = customer.email;
      _phoneController.text = customer.phoneNumber;
      _selectedCustomerType = customer.customerType;
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
      customerType: _selectedCustomerType ?? '',
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
                  _buildTextField("Name", controller: _nameController, hint: "Enter Your Name"),
                  _buildDropdownField(),
                  _buildTextField("Address", controller: _addressController, hint: "Enter Address"),
                  _buildTextField("Phone Number", controller: _phoneController, hint: "Enter Mobile Number"),
                  _buildTextField("Email", controller: _emailController, hint: "Enter Email", isOptional: true),
                  _buildTextField("Mode of Business", controller: _modeofbusinnerController, hint: "e.g. Function Hall, Shop"),
                  _buildTextField("SPOC 1 Contact Number", controller: _spoc1Controller, hint: "Contact Number 1", isOptional: true),
                  _buildTextField("SPOC 2 Contact Number", controller: _spoc2Controller, hint: "Contact Number 2", isOptional: true),
                  _buildTextField("GST Number (Compulsory for B2B)", controller: _gstController, hint: "Enter GST Number"),
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
              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                return Colors.blue;
              }),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.9)),
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

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Customer Type*",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: (_selectedCustomerType == null || _selectedCustomerType!.isEmpty)
                ? null
                : _selectedCustomerType,
            hint: Text(
              'Select Customer Type',
              style: TextStyle(
                color: Colors.grey[800],
                fontFamily: 'Poppins',
              ),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            ),
            items: ["B2B", "B2C"]
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCustomerType = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select Customer Type';
              }
              return null;
            },
          ),
        ],
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            ),
            validator: (value) {
              if (isOptional && (value == null || value.trim().isEmpty)) {
                return null;
              }

              if (!isOptional && (value == null || value.trim().isEmpty)) {
                return 'Please enter $label';
              }

              // Email validation (only if not empty)
              if (label == "Email" &&
                  value != null &&
                  value.trim().isNotEmpty &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email (must contain @ and .com)';
              }

              // Phone number validation (only if not empty)
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
