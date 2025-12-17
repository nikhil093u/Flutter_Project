import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:image_picker/image_picker.dart';

class LogoControls extends StatelessWidget {
  final List<LogoElement> logos;
  final ValueChanged<LogoElement> onAddLogo;
  final ValueChanged<String> onSelectLogo;
  final String? selectedLogoId;
  final ValueChanged<double> onScaleChange;
  final ValueChanged<double> onRotateChange;
  final ValueChanged<File> onPickLogo;

  const LogoControls({
    super.key,
    required this.logos,
    required this.onAddLogo,
    required this.onSelectLogo,
    required this.selectedLogoId,
    required this.onScaleChange,
    required this.onRotateChange,
    required this.onPickLogo,
  });

  Future<void> _pickLogo(BuildContext context) async {
  final picker = ImagePicker();
  final file = await picker.pickImage(source: ImageSource.gallery);
  if (file == null) return;

  onPickLogo(File(file.path)); // ✅ ONLY FILE
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickLogo(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Logo'),
        ),
        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          children: logos.map((logo) {
            final selected = logo.id == selectedLogoId;
            return GestureDetector(
              onTap: () => onSelectLogo(logo.id),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: RawImage(
                  image: logo.image, // ui.Image ✅
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                )
              ),
            );
          }).toList(),
        ),
        if (selectedLogoId != null) ...[
  const SizedBox(height: 12),
  const Text(
    'Adjust Selected Logo',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  const SizedBox(height: 8),

  Row(
    children: [
      IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () => onScaleChange(-0.05),
      ),
      const Text('Size'),
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => onScaleChange(0.05),
      ),
    ],
  ),

  Row(
    children: [
      IconButton(
        icon: const Icon(Icons.rotate_left),
        onPressed: () => onRotateChange(-0.1),
      ),
      const Text('Rotate'),
      IconButton(
        icon: const Icon(Icons.rotate_right),
        onPressed: () => onRotateChange(0.1),
      ),
    ],
  ),
]

      ],
    );
  }
}
