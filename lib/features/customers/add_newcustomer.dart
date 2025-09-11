// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:provider/provider.dart';

class AddCustomerForm extends StatefulWidget {
  final Customer? existingCustomer;
  const AddCustomerForm({super.key,this.existingCustomer});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _nameController = TextEditingController();
  final _customerTypeController = TextEditingController();
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
    _customerTypeController.text = customer.customerType;
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
    _customerTypeController.dispose();
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
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final newCustomer = Customer(
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      customerType: _customerTypeController.text,
      address: _addressController.text,
      modeOfBusiness: _modeofbusinnerController.text,
      spoc1: _spoc1Controller.text,
      spoc2: _spoc2Controller.text,
      gstNumber: _gstController.text,
    );
    if (widget.existingCustomer != null) {
    // Update existing customer
    customerProvider.updateCustomer(widget.existingCustomer!, newCustomer);
  }else{
    customerProvider.addCustomer(newCustomer);
  }
    Navigator.pop(context,newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
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
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 0),
                  //     child: Text(
                  //       "Add Customer",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         fontFamily: 'Poppins',
                  //         fontSize: 18,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),

                  // Input Fields
                  _buildTextField(
                    "Name",
                    controller: _nameController,
                    hint: "Enter Your Name",
                  ),
                  _buildTextField(
                    "Customer Type",
                    controller: _customerTypeController,
                    hint: "e.g. B2B, B2C",
                  ),
                  _buildTextField(
                    "Address",
                    controller: _addressController,
                    hint: "Enter Your Name",
                  ),
                  _buildTextField(
                    "Phone Number",
                    controller: _phoneController,
                    hint: "Enter Mobile Number",
                  ),
                  _buildTextField(
                    "Email (optional)",
                    controller: _emailController,
                    hint: "Enter Email",
                  ),
                  _buildTextField(
                    "Mode of Business",
                    controller: _modeofbusinnerController,
                    hint: "e.g. Functiona Hall, Shop",
                  ),
                  _buildTextField(
                    "SPOC 1 Contact Number",
                    controller: _spoc1Controller,
                    hint: "Contact Number 1",
                  ),
                  _buildTextField(
                    "SPOC 2 Contact Number",
                    controller: _spoc2Controller,
                    hint: "Contact Number 1",
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

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA4CDFD),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shadowColor: Colors.black.withOpacity(0.9),
              elevation: 3,
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
          // Label above the field
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
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (isOptional) return null;
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
