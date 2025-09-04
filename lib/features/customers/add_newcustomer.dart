import 'package:flutter/material.dart';

class AddCustomerForm extends StatelessWidget {
  const AddCustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Oceana",
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(
                        "Add Customer",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Input Fields
                  _buildTextField("Name", hint: "Enter Your Name"),
                  _buildTextField("Customer Type", hint: "e.g. B2B, B2C"),
                  _buildTextField("Address", hint: "Enter Your Name"),
                  _buildTextField(
                    "Phone Number",
                    keyboardType: TextInputType.phone,
                    hint: "Enter Mobile Number",
                  ),
                  _buildTextField(
                    "Email (optional)",
                    keyboardType: TextInputType.emailAddress,
                    hint: "Enter Email",
                  ),
                  _buildTextField(
                    "Mode of Business",
                    hint: "e.g. Functiona Hall, Shop",
                  ),
                  _buildTextField(
                    "SPOC 1 Contact Number",
                    keyboardType: TextInputType.phone,
                    hint: "Contact Number 1",
                  ),
                  _buildTextField(
                    "SPOC 2 Contact Number",
                    keyboardType: TextInputType.phone,
                    hint: "Contact Number 1",
                  ),
                  _buildTextField(
                    "GST Number (Compulsory for B2B)",
                    hint: "Enter GST Number",
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Handle form submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[200],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Save Customer",
                      style: TextStyle(color: Colors.white,fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    TextInputType keyboardType = TextInputType.text,
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
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[800],fontFamily: 'Poppins'),
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
