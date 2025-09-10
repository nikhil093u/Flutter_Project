import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/footer.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  final displayNameController = TextEditingController(text: 'Alex Johnson');
  final businessEmailController = TextEditingController(
    text: 'alex.johnson@business.com',
  );
  final contactNumberController = TextEditingController(
    text: '+00 123 458 789 000',
  );
  final joiningDateController = TextEditingController(text: '01/01/2020');
  final roleController = TextEditingController(text: 'Project Manager');
  final languagesController = TextEditingController(text: 'English, German');
  final officeAddressController = TextEditingController(
    text: '123 Business Rd, New York, USA',
  );
  final specialRequirementsController = TextEditingController(text: 'N/A');
  final dietaryRestrictionsController = TextEditingController(text: '');

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
      child: ListTile(
        leading: Icon(
          LucideIcons.file,
          color: Colors.grey[700],
        ),
        title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
        trailing: Icon(LucideIcons.chevronRight, size: 14, color: Colors.grey),
        onTap: () {
        },
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
          onPressed: () {
            
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        
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
                  child: Icon(LucideIcons.user, size: 50, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '@AlexJohnson',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    
                  },
                  icon: Icon(LucideIcons.edit, size: 18),
                  label: Text(
                    'edit profile',
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
                    label: 'Joining date',
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

            buildLabelledField(
              label: 'Dietary restrictions',
              controller: dietaryRestrictionsController,
              maxLines: 2,
            ),

            const SizedBox(height: 30),

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
            documentItem('Confidentiality'),
            documentItem('Resource Allocation'),

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

            identificationDocumentItem('Emplo', LucideIcons.contact2),
            identificationDocumentItem('Work', LucideIcons.briefcase),
            identificationDocumentItem(
              'Office Access',
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
  }
}
