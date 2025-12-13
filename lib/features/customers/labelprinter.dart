import 'package:flutter/material.dart';

class LabelPainter extends CustomPainter {
  final Color backgroundColor;
  final String backgroundType;

  LabelPainter({
    required this.backgroundColor,
    required this.backgroundType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundType == 'color'
          ? backgroundColor
          : Colors.grey.shade300
      ..style = PaintingStyle.fill;

    /// Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    /// Border
    final borderPaint = Paint()
      ..color = Colors.grey.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant LabelPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.backgroundType != backgroundType;
  }
}
