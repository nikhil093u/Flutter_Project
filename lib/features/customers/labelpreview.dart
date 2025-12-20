import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/labelpainter.dart';
import 'package:flutter_application/features/customers/labelsize.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class LabelPreview extends StatelessWidget {
  final String? labelSizeId;
  final Color backgroundColor;
  final String backgroundType;
  final Offset backgroundImageOffset;
  final void Function(Offset delta) onMoveBackground;

  final List<LogoElement> logos;
  final List<TextElement> textElements;

  final GlobalKey repaintKey;

  final ui.Image? backgroundImage;
  final double backgroundImageScale;
  final String backgroundPattern;
  final double patternScale;

  final String? selectedTextId;

  final void Function(Offset delta) onMoveLogo;
  final void Function(String id, Offset delta) onMoveText;
  final void Function(String id) onSelectText;
final void Function(LogoSlot slot) onSelectLogo;
final VoidCallback clearSelection;
  final LogoSlot? selectedSlot;

  const LabelPreview({
    super.key,
    required this.labelSizeId,
    required this.backgroundColor,
    required this.backgroundType,
    required this.logos,
    required this.textElements,
    required this.repaintKey,
    required this.backgroundImage,
    required this.backgroundImageScale,
    required this.backgroundPattern,
    required this.patternScale,
    required this.selectedTextId,
    required this.onMoveLogo,
    required this.onMoveText,
    required this.backgroundImageOffset,
    required this.onMoveBackground,
    required this.onSelectText,
    required this.onSelectLogo,
    required this.clearSelection,
    required this.selectedSlot,
  });

  void _handleTap(Offset pos, Size canvasSize) {
  for (final text in textElements.reversed) {
    final textPos = Offset(
      text.x * canvasSize.width,
      text.y * canvasSize.height,
    );

    final painter = TextPainter(
      text: TextSpan(
        text: text.text,
        style: TextStyle(fontSize: text.fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final rect = Rect.fromCenter(
      center: textPos,
      width: painter.width,
      height: painter.height,
    );

    if (rect.contains(pos)) {
      onSelectText(text.id);
      return;
    }
  }

  // Check LOGOS
  for (final logo in logos.reversed) {
    final logoPos = Offset(
      logo.x * canvasSize.width,
      logo.y * canvasSize.height,
    );

    final size = canvasSize.shortestSide * logo.scale;

    final rect = Rect.fromCenter(
      center: logoPos,
      width: size,
      height: size,
    );

    if (rect.contains(pos)) {
    onSelectLogo(logo.slot);
    return;
  }
  }

  // Tap empty area → deselect
  clearSelection();
}


  @override
  Widget build(BuildContext context) {
    final labelSize = labelSizes[labelSizeId];
    if (labelSize == null) {
      return const Center(child: Text('No label size selected'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final labelWidthPx = (labelSize.widthMm / 25.4) * 300; // 300 DPI
        final labelHeightPx = (labelSize.heightMm / 25.4) * 300;

        final availableWidth = constraints.maxWidth;
        final screenHeight = MediaQuery.of(context).size.height;
        final maxPreviewHeight = screenHeight * 0.45;

        final scale = math
            .min(
              availableWidth / labelWidthPx,
              maxPreviewHeight / labelHeightPx,
            )
            .clamp(0.18, 1.0);

        final width = labelWidthPx * scale;
        final height = labelHeightPx * scale;

        return Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,

            onTapDown: (details) {
              final localPos = details.localPosition;
              _handleTap(localPos, Size(width, height));
            },

            onPanUpdate: (details) {
  final dx = details.delta.dx / width;
  final dy = details.delta.dy / height;

  if (selectedSlot != null) {
    onMoveLogo(Offset(dx, dy));
  } else if (selectedTextId != null) {
    onMoveText(selectedTextId!, Offset(dx, dy));
  } else if (backgroundType == 'image') {
    onMoveBackground(details.delta);
  }
},


            child: CustomPaint(
              size: Size(width, height),
              painter: LabelPainter(
                backgroundColor: backgroundColor,
                backgroundType: backgroundType,
                backgroundImage: backgroundImage,
                backgroundImageScale: backgroundImageScale,
                backgroundPattern: backgroundPattern,
                patternScale: patternScale,
                logos: logos,
                texts: textElements,
                selectedLogoSlot: selectedSlot,
                selectedTextId: selectedTextId,
                backgroundImageOffset: backgroundImageOffset,
              ),
            ),
          ),
        );
      },
    );
  }
}
