import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/customerprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:provider/provider.dart';

class SelectCustomer extends StatefulWidget {
  const SelectCustomer({super.key});

  @override
  State<SelectCustomer> createState() => _SelectCustomerState();
}

class _SelectCustomerState extends State<SelectCustomer> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  List<Customer> _filteredCustomers = [];
  Customer? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final allCustomers = customerProvider.customers;

    setState(() {
      _filteredCustomers = allCustomers.where((customer) {
        return customer.name.toLowerCase().contains(query) ||
            customer.phoneNumber.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onCustomerSelected(Customer customer) {
    setState(() {
      _selectedCustomer = customer;
    });
  }

  void _onProceed() {
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    if (_selectedCustomer != null) {
      Navigator.pushNamed(context, Routes.createorder, arguments: _selectedCustomer);
    } else if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      
      final newCustomer = Customer(
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        customerType: 'Retail', 
        gstNumber: '',
        modeOfBusiness: '',
        profileImageUrl: '',
        spoc1: '',
        spoc2: '',
      );

      customerProvider.addCustomer(newCustomer);
      Navigator.pushNamed(context, Routes.createorder, arguments: newCustomer);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select or create a customer.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Oceana",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Order",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Search Customer",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField("Enter name or phone", _searchController),

            const SizedBox(height: 12),
            if (_filteredCustomers.isEmpty && _searchController.text.isNotEmpty)
              const Text(
                "No matching customers found.",
                style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
              )
            else if (_filteredCustomers.isNotEmpty)
              Column(
                children: _filteredCustomers.map((customer) {
                  return GestureDetector(
                    onTap: () => _onCustomerSelected(customer),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedCustomer == customer
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildCustomerCard(
                        customer.name,
                        customer.phoneNumber,
                        customer.email,
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 24),
            const Text(
              "Or Create New Customer",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField("Customer Name", _nameController),
            const SizedBox(height: 12),
            _buildTextField("Contact Email", _emailController),
            const SizedBox(height: 12),
            _buildTextField("Phone Number", _phoneController),
            const SizedBox(height: 12),
            _buildTextField("Address", _addressController),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: const TextStyle(fontFamily: 'Poppins'),
    );
  }

  Widget _buildCustomerCard(String name, String phone, String email) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phone,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
        ],
      ),
    );
  }
}
