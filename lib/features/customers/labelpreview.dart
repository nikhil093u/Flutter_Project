import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/labelprinter.dart';
import 'package:flutter_application/features/customers/labelsize.dart';

class LabelPreview extends StatelessWidget {
  final String? labelSizeId;
  final Color backgroundColor;
  final String backgroundType;

  const LabelPreview({
    super.key,
    required this.labelSizeId,
    required this.backgroundColor,
    required this.backgroundType,
  });

  @override
  Widget build(BuildContext context) {
    final labelSize = labelSizes[labelSizeId];

    if (labelSize == null) {
      return const Center(child: Text('No label size selected', style: TextStyle(fontFamily: 'Poppins')));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = 260.0;

        /// Maintain correct aspect ratio
        final aspectRatio = labelSize.heightMm / labelSize.widthMm;

        double canvasWidth = maxWidth;
        double canvasHeight = canvasWidth * aspectRatio;

        if (canvasHeight > maxHeight) {
          canvasHeight = maxHeight;
          canvasWidth = canvasHeight / aspectRatio;
        }

        return Center(
          child: CustomPaint(
            size: Size(canvasWidth, canvasHeight),
            painter: LabelPainter(
              backgroundColor: backgroundColor,
              backgroundType: backgroundType,
            ),
          ),
        );
      },
    );
  }
}
