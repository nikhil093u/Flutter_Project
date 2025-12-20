import 'dart:math' as math;
import 'package:flutter/material.dart';

class PatternPreviewPainter extends CustomPainter {
  final String pattern;
  final Color baseColor;

  PatternPreviewPainter({
    required this.pattern,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Base background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = baseColor,
    );

    // ignore: deprecated_member_use
    final paint = Paint()..color = Colors.black.withOpacity(0.15);

    if (pattern == 'stripes') {
      for (double x = 0; x < size.width; x += 12) {
        canvas.drawRect(
          Rect.fromLTWH(x, 0, 6, size.height),
          paint,
        );
      }
    }

    if (pattern == 'dots') {
      for (double x = 8; x < size.width; x += 16) {
        for (double y = 8; y < size.height; y += 16) {
          canvas.drawCircle(Offset(x, y), 2, paint);
        }
      }
    }

    if (pattern == 'waves') {
      final wavePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        // ignore: deprecated_member_use
        ..color = Colors.blue.withOpacity(0.4);

      for (double y = 6; y < size.height; y += 12) {
        final path = Path()..moveTo(0, y);
        for (double x = 0; x < size.width; x++) {
          final waveY = y + math.sin(x / 10) * 3;
          path.lineTo(x, waveY);
        }
        canvas.drawPath(path, wavePaint);
      }
    }

    if (pattern == 'gradient') {
      final gradientPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [baseColor, Colors.blue],
        ).createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );

      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        gradientPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PatternPreviewPainter old) {
    return old.pattern != pattern || old.baseColor != baseColor;
  }
}
