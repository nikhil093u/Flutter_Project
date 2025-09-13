import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController displayNameController;
  late TextEditingController businessEmailController;
  late TextEditingController contactNumberController;
  late TextEditingController joiningDateController;
  late TextEditingController roleController;
  late TextEditingController languagesController;
  late TextEditingController officeAddressController;
  late TextEditingController specialRequirementsController;
  late TextEditingController dietaryRestrictionsController;

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController();
    businessEmailController = TextEditingController();
    contactNumberController = TextEditingController();
    joiningDateController = TextEditingController();
    roleController = TextEditingController();
    languagesController = TextEditingController();
    officeAddressController = TextEditingController();
    specialRequirementsController = TextEditingController();
    dietaryRestrictionsController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;

    if (currentUser != null) {
      displayNameController.text =
          '${currentUser.firstName} ${currentUser.lastName}';
      businessEmailController.text = currentUser.email;
      contactNumberController.text = currentUser.phone;
      joiningDateController.text = currentUser.dob;

      roleController.text = 'User';
      languagesController.text = 'English';
      officeAddressController.text =
          'SmatWork Innovations Pvt. Ltd. 104, Supriya Estates, Prashant Hills,RaiDurga, Hyderabad, Telangana 500008';
      specialRequirementsController.text = 'N/A';
      dietaryRestrictionsController.text = '';
    }
  }

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
        Navigator.pushNamed(context, Routes.setting);
        break;
    }
  }

  void _logout() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.logout();
    Navigator.pushNamedAndRemoveUntil(context, Routes.signin, (route) => false);
  }

  void _saveProfile() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
  }

  @override
  void dispose() {
    displayNameController.dispose();
    businessEmailController.dispose();
    contactNumberController.dispose();
    joiningDateController.dispose();
    roleController.dispose();
    languagesController.dispose();
    officeAddressController.dispose();
    specialRequirementsController.dispose();
    dietaryRestrictionsController.dispose();
    super.dispose();
  }

  Widget buildLabelledField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    Widget? suffix,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  Widget documentItem(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: Color(0xFFD3D3D3),
      child: ListTile(
        leading: Icon(LucideIcons.file, color: Colors.grey[700]),
        title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
        trailing: Icon(LucideIcons.chevronRight, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  Widget identificationDocumentItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: Colors.blue, width: 5)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
        trailing: IconButton(
          icon: Icon(LucideIcons.edit, color: Colors.blue),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final currentUser = authProvider.currentUser;

        if (currentUser == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, Routes.signin);
          });
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
            ),
            title: Text(
              "Settings",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(LucideIcons.logOut, color: Colors.red),
                onPressed: _logout,
                tooltip: 'Logout',
              ),
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        '${currentUser.firstName[0]}${currentUser.lastName[0]}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@${currentUser.firstName}${currentUser.lastName}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            currentUser.email,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _saveProfile,
                      icon: Icon(LucideIcons.save, size: 18),
                      label: Text(
                        'save profile',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size(80, 30),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: buildLabelledField(
                        label: 'Display name',
                        controller: displayNameController,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildLabelledField(
                        label: 'Business email',
                        controller: businessEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: buildLabelledField(
                        label: 'Contact number',
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildLabelledField(
                        label: 'Date of Birth',
                        controller: joiningDateController,
                        readOnly: true,
                        suffix: Icon(LucideIcons.calendar),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: buildLabelledField(
                        label: 'Role',
                        controller: roleController,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildLabelledField(
                        label: 'Languages spoken',
                        controller: languagesController,
                        suffix: Icon(Icons.edit_outlined),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: buildLabelledField(
                        label: 'Office address',
                        controller: officeAddressController,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: buildLabelledField(
                        label: 'Special requirements',
                        controller: specialRequirementsController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Text(
                  'Documents',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),

                documentItem('Project Proposal.pdf'),
                documentItem('Invoice Template.pdf'),
                documentItem('Confidentiality Agreement.pdf'),
                documentItem('Resource Allocation.pdf'),

                const SizedBox(height: 30),

                Text(
                  'Identification Documents',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),

                identificationDocumentItem('Employee ID', LucideIcons.contact2),
                identificationDocumentItem(
                  'Work Permit',
                  LucideIcons.briefcase,
                ),
                identificationDocumentItem(
                  'Office Access Card',
                  LucideIcons.lock,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
          bottomNavigationBar: Footer(
            currentIndex: 4,
            onTap: (index) => _onTabTapped(context, index),
          ),
        );
      },
    );
  }
}
