import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/services/apiservice.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CustomerDetailsScreen extends StatefulWidget {
  final Uint8List previewImageBytes;
  final String selectedLabelSize;
  final String selectedCategory;
  final Map<LogoSlot, LogoElement?> logos;
  final List<TextElement> textElements;

  const CustomerDetailsScreen({
    super.key,
    required this.previewImageBytes,
    required this.selectedLabelSize,
    required this.selectedCategory,
    required this.logos,
    required this.textElements,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final zipCtrl = TextEditingController();

  String? stateId;
  bool loading = false;
  bool showBottlePreview = false;
  bool submitting = false;
String uploadStatus = '';
final storage = FlutterSecureStorage();

  bool get hasLogo =>
      widget.logos.values.any((logo) => logo != null);

  // void submit() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() => loading = true);

  //   final payload = {
  //     "name": nameCtrl.text,
  //     "phone": phoneCtrl.text,
  //     "email": emailCtrl.text,
  //     "street": streetCtrl.text,
  //     "city": cityCtrl.text,
  //     "state_id": stateId,
  //     "zip": zipCtrl.text,
  //     "labelSize": widget.selectedLabelSize,
  //     "category": widget.selectedCategory,
  //     "logos": widget.logos.map((k, v) => MapEntry(k.name, v != null)),
  //     "textCount": widget.textElements.length,
  //     // "previewImage": widget.previewImageBytes,
  //   };

  //   debugPrint("FINAL PAYLOAD → $payload");

  //   await Future.delayed(const Duration(seconds: 2));

  //   if (!mounted) return;
  //   setState(() => loading = false);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Customer created successfully")),
  //   );
  // }
  Future<void> handleFinalSubmit() async {
  if (submitting) return;

  if (!_formKey.currentState!.validate()) return;

  try {
    setState(() {
      submitting = true;
      uploadStatus = 'Generating label...';
    });

    /// 1️⃣ Generate presigned URL
    final presigned = await ApiService.generatePresignedUrl(
      filename: 'label.jpg',
      contentType: 'image/jpeg',
    );
    final uploadUrl = presigned['upload_url'];
    final s3Key = presigned['s3_key'];

    /// 2️⃣ Upload label image to S3
    setState(() => uploadStatus = 'Uploading label...');
    await ApiService.uploadToS3(
      uploadUrl: uploadUrl,
      bytes: widget.previewImageBytes,
    );

    /// 3️⃣ Create multipart request
    final uri = Uri.parse(
      '${ApiService.baseUrl}/fastapi/odoo/order-management/customers',
    );

    final request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'name': nameCtrl.text,
      'phone': phoneCtrl.text,
      'email': emailCtrl.text,
      'street': streetCtrl.text,
      'city': cityCtrl.text,
      'state_id': stateId ?? '',
      'zip': zipCtrl.text,
      'category': widget.selectedCategory,
      'label_size': widget.selectedLabelSize,
      'label_s3_key': s3Key,
      'design_metadata': jsonEncode({
        'labelSize': widget.selectedLabelSize,
        'category': widget.selectedCategory,
        'textCount': widget.textElements.length,
        'logoCount':
            widget.logos.values.where((e) => e != null).length,
      }),
    });

    final token = await storage.read(key: 'auth_token');
    request.headers['Authorization'] = 'Bearer $token';

    /// 4️⃣ Submit customer
    setState(() => uploadStatus = 'Saving customer...');
    final response = await request.send();

    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw Exception(body);
    }

    /// ✅ SUCCESS
    if (!mounted) return;

    setState(() {
      submitting = false;
      uploadStatus = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer created successfully')),
    );

    Navigator.pop(context);

  } catch (e) {
    setState(() {
      submitting = false;
      uploadStatus = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Customer Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.memory(
                          widget.previewImageBytes,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Size: ${widget.selectedLabelSize}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Category: ${widget.selectedCategory}"),
                              Text("Text Elements: ${widget.textElements.length}"),
                              Text("Logo: ${hasLogo ? 'Yes' : 'No'}"),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => showBottlePreview = true);
                                },
                                child: const Text("Preview on bottle"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _input(controller: nameCtrl, label: "Name", required: true),
                      _input(
                        controller: phoneCtrl,
                        label: "Phone",
                        keyboard: TextInputType.phone,
                        required: true,
                      ),
                      _input(
                        controller: emailCtrl,
                        label: "Email",
                        keyboard: TextInputType.emailAddress,
                      ),
                      _input(controller: streetCtrl, label: "Street", required: true),
                      _input(controller: cityCtrl, label: "City", required: true),

                      DropdownButtonFormField<String>(
                        initialValue: (stateId == null) ? null : stateId,
                        dropdownColor: Colors.grey.shade200,
                        decoration: const InputDecoration(labelText: "State"),
                        items: const [
                          DropdownMenuItem(
                              value: "andhra", child: Text("Andhra Pradesh")),
                          DropdownMenuItem(
                              value: "telangana", child: Text("Telangana")),
                        ],
                        onChanged: (v) => setState(() => stateId = v ?? ''),
                        validator: (v) =>
                            v == null || v.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 12),

                      _input(
                        controller: zipCtrl,
                        label: "Postal Code",
                        keyboard: TextInputType.number,
                        required: true,
                        maxLength: 6,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: loading ? null : () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (submitting && uploadStatus.isNotEmpty)
  Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      uploadStatus,
      style: const TextStyle(color: Colors.grey),
    ),
  ),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(  
                          backgroundColor: const Color.fromARGB(255, 87, 141, 89)
                        ),
                        onPressed: loading ? null : handleFinalSubmit,
                        child: loading
                            ? const SizedBox(
                                height: 30,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text("Create Customer & Save Design"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (showBottlePreview)
            _BottlePreview(
              imageBytes: widget.previewImageBytes,
              onClose: () {
                setState(() => showBottlePreview = false);
              },
            ),
        ],
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    bool required = false,
    int? maxLength,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLength: maxLength,
        decoration: InputDecoration(labelText: label),
        validator: required
            ? (v) => v == null || v.isEmpty ? "Required" : null
            : null,
      ),
    );
  }
}

class _BottlePreview extends StatelessWidget {
  final Uint8List imageBytes;
  final VoidCallback onClose;

  const _BottlePreview({
    required this.imageBytes,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.85),
        child: Stack(
          children: [
            Center(
              child: Image.memory(
                imageBytes,
                height: 450,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
