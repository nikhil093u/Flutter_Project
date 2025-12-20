import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LogoElement {
  final String id;
  final LogoSlot slot;
  final ui.Image image;
  double x;
  double y;
  double scale;
  double rotation;

  LogoElement({
    required this.id,
    required this.slot,
    required this.image,
    this.x = 0.5,
    this.y = 0.5,
    this.scale = 0.3,
    this.rotation = 0,
  });
}
enum LogoSlot {
  primaryLogo,
  secondaryLogo,
  qrCode,
}
Future<ui.Image> loadUiImage(ImageProvider provider) async {
  final completer = Completer<ui.Image>();
  final stream = provider.resolve(const ImageConfiguration());
  stream.addListener(
    ImageStreamListener((ImageInfo info, _) {
      completer.complete(info.image);
    }),
  );
  return completer.future;
}
const Map<LogoSlot, Map<String, double>> defaultLogoPositions = {
  LogoSlot.primaryLogo: {'x': 0.5, 'y': 0.25, 'scale': 0.5},
  LogoSlot.qrCode: {'x': 0.5, 'y': 0.85, 'scale': 0.3},
  LogoSlot.secondaryLogo: {'x': 0.5, 'y': 0.5, 'scale': 0.4},
};