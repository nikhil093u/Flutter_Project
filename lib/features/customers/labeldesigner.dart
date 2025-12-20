import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/features/customers/backgroundcontrols.dart';
import 'package:flutter_application/features/customers/customerdetailsform.dart';
import 'package:flutter_application/features/customers/labelpreview.dart';
import 'package:flutter_application/features/customers/logo_controls.dart';
import 'package:flutter_application/features/customers/text_controls.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';
import 'package:image_picker/image_picker.dart';

class LabelDesigner extends StatefulWidget {
  final String? labelSize;
  final String? labelDescription;
  final String? category;

  const LabelDesigner({
    super.key,
    required this.labelSize,
    required this.labelDescription,
    required this.category,
  });
  @override
  State<LabelDesigner> createState() => _LabelDesignerState();
}

class _LabelDesignerState extends State<LabelDesigner> {
  Map<LogoSlot, LogoElement?> logos = {
    LogoSlot.primaryLogo: null,
    LogoSlot.secondaryLogo: null,
    LogoSlot.qrCode: null,
  };

  LogoSlot? selectedSlot;
  List<TextElement> textElements = [];
  String? selectedTextId;
  final GlobalKey _previewKey = GlobalKey();
  Uint8List? previewImageBytes;
  String backgroundType = 'color';
  Color backgroundColor = Colors.white;
  ui.Image? backgroundImage;
  double backgroundImageScale = 1.0;
  String? selectedPattern;
  ui.Image? patternImage;
  String backgroundPattern =
      'solid'; // solid, stripes, dots, waves, gradient, droplets
  double patternScale = 1.0;
  Offset backgroundImageOffset = Offset.zero;

  void goToCustomerDetails() async {
    final previewBytes = await capturePreviewImage();
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerDetailsScreen(
          previewImageBytes: previewBytes,
          selectedLabelSize: widget.labelSize!,
          selectedCategory: widget.category!,
          logos: logos,
          textElements: textElements,
        ),
      ),
    );
  }

  Future<void> _pickLogoForSlot(LogoSlot slot, File file) async {
    final uiImage = await loadUiImage(FileImage(file));
    final defaults = defaultLogoPositions[slot]!;

    setState(() {
      logos = {
        ...logos,
        slot: LogoElement(
          id: slot.name,
          image: uiImage,
          slot: slot,
          x: defaults['x']!,
          y: defaults['y']!,
          scale: defaults['scale']!,
          rotation: 0,
        ),
      };
      selectedSlot = slot;
    });
  }

  void _scaleLogo(double delta) {
    if (selectedSlot == null) return;

    final logo = logos[selectedSlot];
    if (logo == null) return;

    setState(() {
      logos = {
        ...logos,
        selectedSlot!: LogoElement(
          id: logo.id,
          image: logo.image,
          slot: logo.slot,
          x: logo.x,
          y: logo.y,
          scale: (logo.scale + delta).clamp(0.1, 1.0),
          rotation: logo.rotation,
        ),
      };
    });
  }

  void _rotateLogo(double delta) {
    if (selectedSlot == null) return;

    final logo = logos[selectedSlot];
    if (logo == null) return;

    setState(() {
      logos = {
        ...logos,
        selectedSlot!: LogoElement(
          id: logo.id,
          image: logo.image,
          slot: logo.slot,
          x: logo.x,
          y: logo.y,
          scale: logo.scale,
          rotation: logo.rotation + delta,
        ),
      };
    });
  }

  void _moveLogo(LogoSlot slot, Offset delta) {
    final logo = logos[slot];
    if (logo == null) return;

    setState(() {
      logos = {
        ...logos,
        slot: LogoElement(
          id: logo.id,
          image: logo.image,
          slot: logo.slot,
          x: (logo.x + delta.dx).clamp(0.0, 1.0),
          y: (logo.y + delta.dy).clamp(0.0, 1.0),
          scale: logo.scale,
          rotation: logo.rotation,
        ),
      };
    });
  }

  void _removeLogo(LogoSlot slot) {
    setState(() {
      logos = {...logos, slot: null};
      if (selectedSlot == slot) selectedSlot = null;
    });
  }

  void _moveText(String id, Offset delta) {
    setState(() {
      final t = textElements.firstWhere((t) => t.id == id);
      t.x = (t.x + delta.dx).clamp(0, 1);
      t.y = (t.y + delta.dy).clamp(0, 1);
    });
  }

  void _addText() {
    setState(() {
      final text = TextElement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      textElements.add(text);
      selectedTextId = text.id;
    });
  }

  void _selectText(String id) {
    setState(() {
      selectedTextId = id;
      selectedSlot = null;
    });
  }

  void _updateText(String id, TextElement updated) {
    setState(() {
      textElements = textElements.map((t) {
        if (t.id == id) {
          return TextElement(
            id: t.id,
            text: updated.text,
            x: t.x,
            y: t.y,
            fontSize: updated.fontSize,
            rotation: updated.rotation,
            opacity: updated.opacity,
            color: updated.color,
            align: updated.align,
          );
        }
        return t;
      }).toList();
    });
  }

  void _deleteText(String id) {
    setState(() {
      textElements.removeWhere((t) => t.id == id);
      if (selectedTextId == id) selectedTextId = null;
    });
  }

  void _setBackgroundImage(ui.Image image) {
    setState(() {
      backgroundImage = image;
      backgroundType = 'image';
      backgroundImageScale = 1.0;
    });
  }

  void _scaleBackgroundImage(double delta) {
    setState(() {
      backgroundImageScale = (backgroundImageScale + delta).clamp(0.5, 3.0);
    });
  }

  void _selectPattern(String pattern) {
    setState(() {
      backgroundType = 'pattern';
      backgroundPattern = pattern; // 'dots', 'waves', etc.
    });
  }

  Future<void> _pickBackgroundImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final image = await loadUiImage(FileImage(File(file.path)));
    _setBackgroundImage(image);
  }

  Future<Uint8List> capturePreviewImage() async {
    final boundary =
        _previewKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0); // 300 DPI-ish
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final logoList = logos.values.whereType<LogoElement>().toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// PREVIEW (Always on top)
          _buildSection(
            title: 'Preview',
            child: LabelPreview(
              labelSizeId: widget.labelSize,
              backgroundColor: backgroundColor,
              backgroundType: backgroundType,
              backgroundImage: backgroundImage,
              backgroundImageScale: backgroundImageScale,
              logos: logoList,
              textElements: textElements,
              repaintKey: _previewKey,
              selectedTextId: selectedTextId,
              backgroundImageOffset: backgroundImageOffset,
              selectedSlot: selectedSlot,
              onMoveBackground: (delta) {
                setState(() {
                  backgroundImageOffset += delta;
                });
              },
              onMoveLogo: (delta) {
                if (selectedSlot != null) {
                  _moveLogo(selectedSlot!, delta);
                }
              },
              onSelectText: (id) {
                setState(() {
                  selectedTextId = id;
                  selectedSlot = null;
                });
              },
              onSelectLogo: (slot) {
                setState(() {
                  selectedSlot = slot;
                  selectedTextId = null;
                });
              },
              clearSelection: () {
                setState(() {
                  selectedSlot = null;
                  selectedTextId = null;
                });
              },
              onMoveText: _moveText,
              backgroundPattern: backgroundPattern,
              patternScale: patternScale,
            ),
          ),

          /// BACKGROUND CONTROLS
          _buildSection(
            title: 'Background',
            child: BackgroundControls(
              backgroundType: backgroundType,
              backgroundColor: backgroundColor,

              onBackgroundTypeChange: (type) {
                setState(() => backgroundType = type);
              },

              onBackgroundColorChange: (color) {
                setState(() => backgroundColor = color);
              },

              onPickImage: _pickBackgroundImage,
              onScaleUp: () => _scaleBackgroundImage(0.1),
              onScaleDown: () => _scaleBackgroundImage(-0.1),
              onPatternSelect: _selectPattern,
            ),
          ),

          /// LOGO CONTROLS
          _buildSection(
            title: 'Logos',
            child: LogoControls(
              logos: logos,
              selectedSlot: selectedSlot,
              onRemoveLogo: _removeLogo,
              onSelectSlot: (slot) {
                setState(() {
                  selectedSlot = slot;
                  selectedTextId = null;
                });
              },
              onPickLogo: _pickLogoForSlot,
              onScaleChange: _scaleLogo,
              onRotateChange: _rotateLogo,
            ),
          ),

          /// TEXT CONTROLS
          _buildSection(
            title: 'Text',
            child: TextControls(
              texts: textElements,
              selectedTextId: selectedTextId,
              onAddText: _addText,
              onSelectText: _selectText,
              onUpdateText: _updateText,
              onDeleteText: _deleteText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: goToCustomerDetails,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
