class LabelSize {
  final String id;
  final String name;
  final double width;
  final double height;
  final String description;
  final double aspectRatio;

  LabelSize({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.description,
    required this.aspectRatio,
  });
}

final List<LabelSize> labelSizes = [
  LabelSize(
    id: '33x78.2',
    name: '33 × 78.2 MM',
    width: 40,
    height: 84.5,
    description: '200ml',
    aspectRatio: 84.5 / 40,
  ),
  LabelSize(
    id: '43x128.2',
    name: '43 × 128.2 MM',
    width: 50,
    height: 133.5,
    description: '500ml',
    aspectRatio: 133.5 / 50,
  ),
  LabelSize(
    id: '53x148.2',
    name: '53 × 148.2 MM',
    width: 60,
    height: 155.5,
    description: '700ml',
    aspectRatio: 155.5 / 60,
  ),
  LabelSize(
    id: '53x148.20',
    name: '53 × 148.2 MM',
    width: 60,
    height: 155.5,
    description: '1000ml',
    aspectRatio: 155.5 / 60,
  ),
];
