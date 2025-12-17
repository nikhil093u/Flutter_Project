import 'dart:ui';

class TextElement {
  final String id;
  String text;
  double x;
  double y;
  double fontSize;
  double rotation;
  double opacity;
  Color color;
  TextAlign align;

  TextElement({
    required this.id,
    this.text = 'Enter Text',
    this.x = 0.5,
    this.y = 0.5,
    this.fontSize = 20,
    this.rotation = 0,
    this.opacity = 1,
    this.color = const Color(0xFF000000),
    this.align = TextAlign.center,
  });
}
