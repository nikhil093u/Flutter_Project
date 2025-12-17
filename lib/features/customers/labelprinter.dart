import 'package:flutter/material.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class LabelPainter extends CustomPainter {
  final Color backgroundColor;
  final List<LogoElement> logos;
  final String? selectedLogoId;
  final String? selectedTextId;
  final List<TextElement> texts;

  LabelPainter({
    required this.backgroundColor,
    required this.logos,
    required this.selectedLogoId,
    required this.selectedTextId,
    required this.texts,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// Background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    /// Draw logos
    for (final logo in logos) {
      final dx = logo.x * size.width;
      final dy = logo.y * size.height;

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(logo.rotation);

      final imageSize = size.shortestSide * logo.scale;
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: imageSize,
        height: imageSize,
      );

      paintImage(
        canvas: canvas,
        rect: rect,
        image: logo.image,
        fit: BoxFit.contain,
      );

      /// Highlight selected logo
      if (logo.id == selectedLogoId) {
        canvas.drawRect(
          rect.inflate(4),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = Colors.blue
            ..strokeWidth = 2,
        );
      }

      canvas.restore();
    }

    /// Draw Text
    for (final text in texts) {
  final dx = text.x * size.width;
  final dy = text.y * size.height;

  canvas.save();
  canvas.translate(dx, dy);
  canvas.rotate(text.rotation);

  final textPainter = TextPainter(
    text: TextSpan(
      text: text.text,
      style: TextStyle(
        fontSize: text.fontSize,
        // ignore: deprecated_member_use
        color: text.color.withOpacity(text.opacity),
      ),
    ),
    textAlign: text.align,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout();

  textPainter.paint(
    canvas,
    Offset(-textPainter.width / 2, -textPainter.height / 2),
  );

  canvas.restore();
}


    /// Outer border
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = Colors.grey,
    );
  }

  @override
  bool shouldRepaint(covariant LabelPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.logos != logos ||
        oldDelegate.selectedLogoId != selectedLogoId;
  }
}
