import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LogoElement {
  final String id;
  final ui.Image image;
  double x; // normalized 0–1
  double y;
  double scale;
  double rotation;

  LogoElement({
    required this.id,
    required this.image,
    this.x = 0.5,
    this.y = 0.5,
    this.scale = 0.3,
    this.rotation = 0,
  });
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