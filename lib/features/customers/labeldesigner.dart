import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/backgroundcontrols.dart';
import 'package:flutter_application/features/customers/labelpreview.dart';

class LabelDesigner extends StatelessWidget {
  final String? labelSize;
  final String? labelDescription;
  final String? category;
  final Color backgroundColor;
  final String backgroundType;

  final ValueChanged<String> onBackgroundTypeChange;
  final ValueChanged<Color> onBackgroundColorChange;

  const LabelDesigner({
    super.key,
    required this.labelSize,
    required this.labelDescription,
    required this.category,
    required this.backgroundColor,
    required this.backgroundType,
    required this.onBackgroundTypeChange,
    required this.onBackgroundColorChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// PREVIEW (Always on top)
          _buildSection(
            title: 'Preview',
            child: LabelPreview(
              labelSizeId: labelSize,
              backgroundColor: backgroundColor,
              backgroundType: backgroundType,
            ),
          ),

          /// BACKGROUND CONTROLS
          _buildSection(
            title: 'Background',
            child: BackgroundControls(backgroundType: backgroundType,
            backgroundColor: backgroundColor,
            onBackgroundTypeChange: onBackgroundTypeChange,
            onBackgroundColorChange: onBackgroundColorChange),
          ),

          /// LOGO CONTROLS
          _buildSection(
            title: 'Logos',
            child: _buildPlaceholder('Logo Controls'),
          ),

          /// TEXT CONTROLS
          _buildSection(
            title: 'Text',
            child: _buildPlaceholder('Text Controls'),
          ),
        ],
      ),
    );
  }
  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String label) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
