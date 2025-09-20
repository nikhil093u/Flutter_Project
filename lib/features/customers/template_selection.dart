import 'package:flutter/material.dart';
import 'package:flutter_application/features/customers/logo_overlay_screen.dart';

// LabelTemplate data model
class LabelTemplate {
  final String id;
  final String name;
  final Color bgColor;
  final String pattern;

  LabelTemplate({
    required this.id,
    required this.name,
    required this.bgColor,
    this.pattern = 'default',
  });
}

// Custom Painter for template drawing
class LabelTemplatePainter extends CustomPainter {
  final LabelTemplate template;

  LabelTemplatePainter(this.template);

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    Gradient gradient;
    if (template.pattern == 'water-bottle') {
      gradient = LinearGradient(
        colors: [
          Colors.lightBlue.shade100,
          Colors.lightBlueAccent,
          Colors.blue.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (template.pattern == 'elegant') {
      gradient = LinearGradient(
        colors: [Colors.white, Colors.grey.shade300],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      gradient = LinearGradient(colors: [template.bgColor, template.bgColor]);
    }
    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Border
    final borderPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);

    // Logo placeholder (dashed rect)
    final logoSize = size.shortestSide * 0.5;
    final logoRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: logoSize,
      height: logoSize,
    );
    final dashPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _drawDashedRect(canvas, logoRect, dashPaint, dashWidth: 8, dashGap: 6);

    // "LOGO" text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'LOGO',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontFamily: 'poppins',
          fontWeight: FontWeight.bold,

        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textOffset = Offset(
      size.width / 2 - textPainter.width / 2,
      size.height / 2 - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);

    // Template name text
    final namePainter = TextPainter(
      text: TextSpan(
        text: template.name,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: 'poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    namePainter.layout();
    final nameOffset = Offset(
      size.width / 2 - namePainter.width / 2,
      size.height - 30,
    );
    namePainter.paint(canvas, nameOffset);
  }

  void _drawDashedRect(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    required double dashWidth,
    required double dashGap,
  }) {
    final path = Path();

    double x = rect.left;
    while (x < rect.right) {
      final endX = (x + dashWidth < rect.right) ? x + dashWidth : rect.right;
      path.moveTo(x, rect.top);
      path.lineTo(endX, rect.top);
      x += dashWidth + dashGap;
    }

    double y = rect.top;
    while (y < rect.bottom) {
      final endY = (y + dashWidth < rect.bottom) ? y + dashWidth : rect.bottom;
      path.moveTo(rect.right, y);
      path.lineTo(rect.right, endY);
      y += dashWidth + dashGap;
    }

    x = rect.right;
    while (x > rect.left) {
      final endX = (x - dashWidth > rect.left) ? x - dashWidth : rect.left;
      path.moveTo(x, rect.bottom);
      path.lineTo(endX, rect.bottom);
      x -= dashWidth + dashGap;
    }

    y = rect.bottom;
    while (y > rect.top) {
      final endY = (y - dashWidth > rect.top) ? y - dashWidth : rect.top;
      path.moveTo(rect.left, y);
      path.lineTo(rect.left, endY);
      y -= dashWidth + dashGap;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LabelTemplateWidget extends StatelessWidget {
  final LabelTemplate template;

  const LabelTemplateWidget({required this.template, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(320, 240),
      painter: LabelTemplatePainter(template),
    );
  }
}

List<LabelTemplate> getTemplatesForCategory(String? category) {
  if (category == null || category.trim().isEmpty) {
    return [];
  }

  return [
    LabelTemplate(
      id: 'classic-white',
      name: 'Classic White',
      bgColor: Colors.white,
      pattern: 'default',
    ),
    LabelTemplate(
      id: 'fresh-water',
      name: 'Fresh Water',
      bgColor: Colors.lightBlue.shade100,
      pattern: 'water-bottle',
    ),
    LabelTemplate(
      id: 'elegant-rose',
      name: 'Elegant Rose',
      bgColor: Colors.pink.shade100,
      pattern: 'elegant',
    ),
    LabelTemplate(
      id: 'golden-sunset',
      name: 'Golden Sunset',
      bgColor: Colors.amber.shade100,
      pattern: 'default',
    ),
    LabelTemplate(
      id: 'ocean-blue',
      name: 'Ocean Blue',
      bgColor: Colors.lightBlue.shade200,
      pattern: 'default',
    ),
  ];
}

class TemplateSelectionScreen extends StatelessWidget {
  final String category;
  final Function(LabelTemplate) onTemplateSelected;

  const TemplateSelectionScreen({
    required this.category,
    required this.onTemplateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final templates = getTemplatesForCategory(category);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Choose Label Design ($category)',
        style: TextStyle(
          fontFamily: 'poppins',
        ),),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: templates
              .map(
                (template) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LogoOverlayScreen(template: template),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LabelTemplateWidget(template: template),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
