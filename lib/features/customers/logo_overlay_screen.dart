import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'template_selection.dart'; // for LabelTemplate

class LogoOverlayScreen extends StatefulWidget {
  final LabelTemplate template;

  const LogoOverlayScreen({required this.template, super.key});

  @override
  State<LogoOverlayScreen> createState() => _LogoOverlayScreenState();
}

class _LogoOverlayScreenState extends State<LogoOverlayScreen> {
  File? logoFile;
  double posX = 0.5, posY = 0.5, scale = 1.0;

  final picker = ImagePicker();

  Future<void> pickLogo() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        logoFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text('Upload Logo & Adjust',
        style: TextStyle(
          fontFamily: 'poppins'
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Template: ${widget.template.name}',
              style: const TextStyle(fontSize: 18, fontFamily: 'poppins'),
            ),
            const SizedBox(height: 20),
            // Show template + logo overlay here (can be improved with CustomPainter + Stack)
            Container(
              width: 300,
              height: 220,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  LabelTemplateWidget(template: widget.template),
                  if (logoFile != null)
                    Positioned(
                      left: 300 * posX - 50 * scale,
                      top: 220 * posY - 50 * scale,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            posX = (posX + details.delta.dx / 300).clamp(
                              0.0,
                              1.0,
                            );
                            posY = (posY + details.delta.dy / 220).clamp(
                              0.0,
                              1.0,
                            );
                          });
                        },
                        child: Image.file(
                          logoFile!,
                          width: 100 * scale,
                          height: 100 * scale,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: pickLogo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              icon: const Icon(LucideIcons.upload),
              label: const Text(
                'Upload Logo',
                style: TextStyle(fontFamily: 'poppins', color: Colors.white),
              ),
            ),
            if (logoFile != null) ...[
              Slider(
                label: 'Horizontal',
                min: 0,
                max: 1,
                value: posX,
                onChanged: (v) => setState(() => posX = v),
              ),
              Slider(
                label: 'Vertical',
                min: 0,
                max: 1,
                value: posY,
                onChanged: (v) => setState(() => posY = v),
              ),
              Slider(
                label: 'Scale',
                min: 0.3,
                max: 1.5,
                value: scale,
                onChanged: (v) => setState(() => scale = v),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'previewBytes': Uint8List(0),
                    'templateId': widget.template.id,
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Accept & Finish',
                  style: TextStyle(fontFamily: 'poppins', color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
