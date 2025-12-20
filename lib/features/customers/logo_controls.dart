import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application/models/logo_model.dart';

class LogoControls extends StatelessWidget {
  final Map<LogoSlot, LogoElement?> logos;
  final LogoSlot? selectedSlot;

  final void Function(LogoSlot slot) onSelectSlot;
  final void Function(LogoSlot slot, File file) onPickLogo;
  final ValueChanged<double> onScaleChange;
  final ValueChanged<double> onRotateChange;
  final void Function(LogoSlot slot) onRemoveLogo;

  const LogoControls({
    super.key,
    required this.logos,
    required this.selectedSlot,
    required this.onSelectSlot,
    required this.onPickLogo,
    required this.onScaleChange,
    required this.onRotateChange,
    required this.onRemoveLogo,
  });

  static const Map<LogoSlot, String> slotLabels = {
    LogoSlot.primaryLogo: 'Add Logo',
    LogoSlot.secondaryLogo: 'Add Logo (Optional)',
    LogoSlot.qrCode: 'Add QR',
  };

  Future<void> _pickLogo(BuildContext context, LogoSlot slot) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    onPickLogo(slot, File(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: LogoSlot.values.map((slot) {
            final logo = logos[slot];
            final isSelected = selectedSlot == slot;

            return GestureDetector(
              onTap: () {
                if (logos[slot] == null) {
                  _pickLogo(context, slot);
                } else {
                  onSelectSlot(slot);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   width: 72,
                  //   height: 72,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: isSelected ? Colors.blue : Colors.grey,
                  //       width: 2,
                  //     ),
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: logo == null
                  //       ? const Icon(Icons.add, size: 32)
                  //       : RawImage(image: logo.image, fit: BoxFit.contain),
                  // ),
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // MAIN BOX
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: logo == null
                              ? const Icon(Icons.add, size: 32)
                              : RawImage(
                                  image: logo.image,
                                  fit: BoxFit.contain,
                                ),
                        ),

                        // ❌ REMOVE BUTTON (ONLY IF LOGO EXISTS)
                        if (logo != null)
                          Positioned(
                            top: -6,
                            right: -6,
                            child: GestureDetector(
                              onTap: () => onRemoveLogo(slot),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    slot == LogoSlot.primaryLogo
                        ? 'Logo'
                        : slot == LogoSlot.secondaryLogo
                        ? 'Logo (Opt)'
                        : 'QR',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        if (selectedSlot != null && logos[selectedSlot] != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Adjust Selected Logo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

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
        ],
      ],
    );
  }
}
