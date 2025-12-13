import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BackgroundControls extends StatelessWidget {
  final String backgroundType;
  final Color backgroundColor;
  final ValueChanged<String> onBackgroundTypeChange;
  final ValueChanged<Color> onBackgroundColorChange;

  const BackgroundControls({
    super.key,
    required this.backgroundType,
    required this.backgroundColor,
    required this.onBackgroundTypeChange,
    required this.onBackgroundColorChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TYPE SELECTOR
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'color', label: Text('Color', style: TextStyle(fontFamily: 'Poppins'))),
            ButtonSegment(value: 'image', label: Text('Image', style: TextStyle(fontFamily: 'Poppins'))),
          ],
          selected: {backgroundType},
          onSelectionChanged: (value) {
            onBackgroundTypeChange(value.first);
          },
        ),

        const SizedBox(height: 16),

        /// COLOR PICKER
        if (backgroundType == 'color')
          GestureDetector(
            onTap: () => _openColorPicker(context),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: backgroundColor,
                color: const Color.fromARGB(255, 120, 207, 247),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: const Center(
                child: Text(
                  'Tap to select color',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),

        /// IMAGE UPLOAD (later)
        if (backgroundType == 'image')
          Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Upload Image / PDF'),
          ),
      ],
    );
  }

  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Pick Background Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: backgroundColor,
            onColorChanged: onBackgroundColorChange,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
