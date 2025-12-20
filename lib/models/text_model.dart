import 'dart:ui';

class TextElement {
  final String id;
  String text;
  double x;
  double y;
  double fontSize;
  FontWeight fontWeight;
  String fontFamily;  
  double rotation;
  double opacity;
  Color color;
  TextAlign align;

  TextElement({
    required this.id,
    this.text = '',
    this.x = 0.5,
    this.y = 0.5,
    this.fontSize = 10,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Poppins',         
    this.rotation = 0,
    this.opacity = 1,
    this.color = const Color(0xFF000000),
    this.align = TextAlign.center,
  });
  
  TextElement copyWith({
    String? text,
    double? x,
    double? y,
    double? fontSize,
    double? rotation,
    double? opacity,
    Color? color,
    TextAlign? align,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextElement(
      id: id,
      text: text ?? this.text,
      x: x ?? this.x,
      y: y ?? this.y,
      fontSize: fontSize ?? this.fontSize,
      rotation: rotation ?? this.rotation,
      opacity: opacity ?? this.opacity,
      color: color ?? this.color,
      align: align ?? this.align,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
