// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class LabelPainter extends CustomPainter {
  final Color backgroundColor;
  final String backgroundType; // color | image | pattern

  final ui.Image? backgroundImage;
  final double backgroundImageScale;

  final String
  backgroundPattern; // solid | stripes | dots | waves | gradient | droplets
  final double patternScale;

  final List<LogoElement> logos;
  final List<TextElement> texts;
  final LogoSlot? selectedLogoSlot;

  final String? selectedTextId;
  final Offset backgroundImageOffset;

  LabelPainter({
    required this.backgroundColor,
    required this.backgroundType,
    required this.backgroundImage,
    required this.backgroundImageScale,
    required this.backgroundPattern,
    required this.patternScale,
    required this.logos,
    required this.texts,
    required this.selectedLogoSlot,
    required this.selectedTextId,
    required this.backgroundImageOffset,
  });

  void drawDashedRect(Canvas canvas, Rect rect) {
    const dashWidth = 5;
    const dashSpace = 4;

    final paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    void drawDashedLine(Offset start, Offset end) {
      final length = (end - start).distance;
      final direction = (end - start) / length;

      double progress = 0;
      while (progress < length) {
        final p1 = start + direction * progress;
        final p2 = start + direction * math.min(progress + dashWidth, length);
        canvas.drawLine(p1, p2, paint);
        progress += dashWidth + dashSpace;
      }
    }

    drawDashedLine(rect.topLeft, rect.topRight);
    drawDashedLine(rect.topRight, rect.bottomRight);
    drawDashedLine(rect.bottomRight, rect.bottomLeft);
    drawDashedLine(rect.bottomLeft, rect.topLeft);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    /// 1 BASE COLOR
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    /// 2 BACKGROUND IMAGE
    if (backgroundType == 'image' && backgroundImage != null) {
      _drawBackgroundImage(canvas, size);
    }

    /// 3 PROCEDURAL PATTERNS
    if (backgroundType == 'pattern' &&
        backgroundPattern.isNotEmpty &&
        backgroundPattern != 'solid') {
      _drawPattern(canvas, size);
    }

    /// 4 LOGOS
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
      if (logo.slot == selectedLogoSlot) {
        drawDashedRect(canvas, rect.inflate(6));
      }
      canvas.restore();
    }

    /// 5 TEXT
    for (final text in texts) {
      final dx = text.x * size.width;
      final dy = text.y * size.height;

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(text.rotation);

      final painter = TextPainter(
        text: TextSpan(
          text: text.text,
          style: TextStyle(
            fontSize: text.fontSize,
            color: text.color.withOpacity(text.opacity),
            fontWeight: text.fontWeight,
            fontFamily: text.fontFamily,
          ),
        ),
        textAlign: text.align,
        textDirection: TextDirection.ltr,
      );

      painter.layout();
      painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));

      // Highlight selected text
      if (text.id == selectedTextId) {
        drawDashedRect(
          canvas,
          Rect.fromCenter(
            center: Offset.zero,
            width: painter.width + 8,
            height: painter.height + 8,
          ),
        );
      }

      canvas.restore();
    }

    canvas.restore();

    /// 6️⃣ BORDER (outside clip)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = Colors.grey,
    );
  }

  // ================= BACKGROUND IMAGE =================

  void _drawBackgroundImage(Canvas canvas, Size size) {
    final imgW = backgroundImage!.width.toDouble();
    final imgH = backgroundImage!.height.toDouble();

    final scaleX = size.width / imgW;
    final scaleY = size.height / imgH;
    final baseScale = math.min(scaleX, scaleY);

    final scale = baseScale * backgroundImageScale;

    final drawW = imgW * scale;
    final drawH = imgH * scale;

    final clampedOffset = _clampOffset(
      backgroundImageOffset,
      size,
      Size(drawW, drawH),
    );

    final dx = (size.width - drawW) / 2 + clampedOffset.dx;
    final dy = (size.height - drawH) / 2 + clampedOffset.dy;

    canvas.drawImageRect(
      backgroundImage!,
      Rect.fromLTWH(0, 0, imgW, imgH),
      Rect.fromLTWH(dx, dy, drawW, drawH),
      Paint(),
    );
  }

  // ================= PATTERNS =================

  void _drawPattern(Canvas canvas, Size size) {
    final scale = patternScale;
    final basePaint = Paint()..color = Colors.black.withOpacity(0.05);

    // STRIPES
    if (backgroundPattern == 'stripes') {
      for (double x = 0; x < size.width; x += 8 * scale) {
        canvas.drawRect(Rect.fromLTWH(x, 0, 3 * scale, size.height), basePaint);
      }
    }

    // DOTS
    if (backgroundPattern == 'dots') {
      final spacing = 12 * scale;
      final radius = 1.5 * scale;

      for (double x = spacing / 2; x < size.width; x += spacing) {
        for (double y = spacing / 2; y < size.height; y += spacing) {
          canvas.drawCircle(Offset(x, y), radius, basePaint);
        }
      }
    }

    // WAVES
    if (backgroundPattern == 'waves') {
      final wavePaint = Paint()
        ..color = Colors.black.withOpacity(0.04)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final waveHeight = 4 * scale;
      final waveLength = 40 * scale;

      for (double y = 0; y < size.height; y += 15 * scale) {
        final path = Path()..moveTo(0, y);

        for (double x = 0; x <= size.width; x++) {
          final waveY =
              y + math.sin((x / waveLength) * 2 * math.pi) * waveHeight;
          path.lineTo(x, waveY);
        }

        canvas.drawPath(path, wavePaint);
      }
    }

    // GRADIENT
    if (backgroundPattern == 'gradient') {
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [backgroundColor, const Color(0xFF3B82F6)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    }

    // DROPLETS
    if (backgroundPattern == 'droplets') {
      final rnd = math.Random(42);

      for (int i = 0; i < 150; i++) {
        final x = rnd.nextDouble() * size.width;
        final y = rnd.nextDouble() * size.height;
        final r = 2 + rnd.nextDouble() * 2;

        final paint = Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.black.withOpacity(0.05),
            ],
          ).createShader(Rect.fromCircle(center: Offset(x, y), radius: r));

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x, y),
            width: r * 1.4,
            height: r * 1.8,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant LabelPainter old) {
    return old.backgroundColor != backgroundColor ||
        old.backgroundType != backgroundType ||
        old.backgroundImage != backgroundImage ||
        old.backgroundImageScale != backgroundImageScale ||
        old.backgroundPattern != backgroundPattern ||
        old.patternScale != patternScale ||
        old.logos != logos ||
        old.texts != texts ||
        old.backgroundImageOffset != backgroundImageOffset ||
        old.selectedTextId != selectedTextId ||
        old.selectedLogoSlot != selectedLogoSlot;
  }

  Offset _clampOffset(Offset offset, Size canvasSize, Size imageSize) {
    final double maxX = math.max(0.0, (imageSize.width - canvasSize.width) / 2);

    final double maxY = math.max(
      0.0,
      (imageSize.height - canvasSize.height) / 2,
    );

    return Offset(offset.dx.clamp(-maxX, maxX), offset.dy.clamp(-maxY, maxY));
  }
}
