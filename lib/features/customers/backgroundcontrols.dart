import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_application/models/patterns_preview.dart';

class BackgroundControls extends StatelessWidget {
  final String backgroundType;
  final Color backgroundColor;

  final ValueChanged<String> onBackgroundTypeChange;
  final ValueChanged<Color> onBackgroundColorChange;

  final VoidCallback onPickImage;
  final VoidCallback onScaleUp;
  final VoidCallback onScaleDown;
  final ValueChanged<String> onPatternSelect;

  const BackgroundControls({
    super.key,
    required this.backgroundType,
    required this.backgroundColor,
    required this.onBackgroundTypeChange,
    required this.onBackgroundColorChange,
    required this.onPickImage,
    required this.onScaleUp,
    required this.onScaleDown,
    required this.onPatternSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TYPE SELECTOR
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'color', label: Text('Color')),
            ButtonSegment(value: 'image', label: Text('Image')),
            ButtonSegment(value: 'pattern', label: Text('Pattern')),
          ],
          selected: {backgroundType},
          onSelectionChanged: (value) {
            onBackgroundTypeChange(value.first);
          },
        ),

        const SizedBox(height: 12),

        /// COLOR
        if (backgroundType == 'color')
          GestureDetector(
            onTap: () => _openColorPicker(context),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              alignment: Alignment.center,
              child: const Text('Tap to select color'),
            ),
          ),

        /// IMAGE
        if (backgroundType == 'image') ...[
          ElevatedButton.icon(
            onPressed: onPickImage,
            icon: const Icon(Icons.image),
            label: const Text('Pick Background Image'),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onScaleDown,
              ),
              const Text('Scale'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onScaleUp,
              ),
            ],
          ),
        ],

        /// PATTERN (CANVAS-BASED)
        if (backgroundType == 'pattern')
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['stripes', 'dots', 'waves', 'gradient', 'droplets']
                .map((pattern) {
              return GestureDetector(
                onTap: () => onPatternSelect(pattern),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomPaint(
                    painter: PatternPreviewPainter(
                      pattern: pattern,
                      baseColor: backgroundColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
