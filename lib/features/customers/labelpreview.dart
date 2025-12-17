import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/labelprinter.dart';
import 'package:flutter_application/features/customers/labelsize.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class LabelPreview extends StatelessWidget {
  final String? labelSizeId;
  final Color backgroundColor;
  final List<LogoElement> logos;
  final String backgroundType;
  final List<TextElement> textElements;
  final GlobalKey repaintKey;

  final String? selectedLogoId;
  final String? selectedTextId;

  final void Function(String id, Offset delta) onMoveLogo;
  final void Function(String id, Offset delta) onMoveText;

  const LabelPreview({
    super.key,
    required this.labelSizeId,
    required this.backgroundColor,
    required this.backgroundType,
    required this.logos,
    required this.textElements,
    required this.selectedLogoId,
    required this.selectedTextId,
    required this.onMoveLogo,
    required this.onMoveText,
    required this.repaintKey,
  });

  @override
  Widget build(BuildContext context) {
    final labelSize = labelSizes[labelSizeId];
    if (labelSize == null) {
      return const Center(child: Text('No label size selected'));
    }

    final aspectRatio = labelSize.heightMm / labelSize.widthMm;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        const maxHeight = 300.0;

        double width = maxWidth;
        double height = width * aspectRatio;

        if (height > maxHeight) {
          height = maxHeight;
          width = height / aspectRatio;
        }

        return Center(
          child: GestureDetector(
            onPanUpdate: (details) {
              final dx = details.delta.dx / width;
              final dy = details.delta.dy / height;

              if (selectedLogoId != null) {
                onMoveLogo(selectedLogoId!, Offset(dx, dy));
              } else if (selectedTextId != null) {
                onMoveText(selectedTextId!, Offset(dx, dy));
              }
            },
            child: RepaintBoundary(
              key: repaintKey,
              child: CustomPaint(
                size: Size(width, height),
                painter: LabelPainter(
                  backgroundColor: backgroundColor,
                  logos: logos,
                  texts: textElements,
                  selectedLogoId: selectedLogoId,
                  selectedTextId: selectedTextId,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
