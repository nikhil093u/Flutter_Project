import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Uint8List previewImageBytes;
  final String selectedLabelSize;
  final String selectedCategory;
  final List<LogoElement> logos;
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
  State<CustomerDetailsScreen> createState() =>
      _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  void submit() {
    // final payload = {
    //   "name": nameCtrl.text,
    //   "phone": phoneCtrl.text,
    //   "labelSize": widget.selectedLabelSize,
    //   "category": widget.selectedCategory,
    //   "logosCount": widget.logos.length,
    //   "textCount": widget.textElements.length,
    //   "previewImage": widget.previewImageBytes,
    // };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("Customer Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.memory(
                widget.previewImageBytes,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Size: ${widget.selectedLabelSize}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Category: ${widget.selectedCategory}",
            ),

            const SizedBox(height: 24),

            /// === Name ===
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Customer Name",
              ),
            ),

            const SizedBox(height: 12),

            /// === Phone ===
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
            ),

            const SizedBox(height: 24),

            /// === Submit ===
            ElevatedButton(
              onPressed: submit,
              child: const Text("Create Customer & Save Design"),
            ),
          ],
        ),
      ),
    );
  }
}
