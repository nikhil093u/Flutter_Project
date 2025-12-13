class LabelSize {
  final String id;
  final double widthMm;
  final double heightMm;

  const LabelSize({
    required this.id,
    required this.widthMm,
    required this.heightMm,
  });
}

const Map<String, LabelSize> labelSizes = {
  '33x78.2': LabelSize(id: '33x78.2', widthMm: 40, heightMm: 84.5),
  '43x128.2': LabelSize(id: '43x128.2', widthMm: 50, heightMm: 133.5),
  '53x148.2': LabelSize(id: '53x148.2', widthMm: 60, heightMm: 155.5),
};
