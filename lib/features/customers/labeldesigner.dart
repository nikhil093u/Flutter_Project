import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/features/customers/backgroundcontrols.dart';
import 'package:flutter_application/features/customers/customerdetailsform.dart';
import 'package:flutter_application/features/customers/labelpreview.dart';
import 'package:flutter_application/features/customers/logo_controls.dart';
import 'package:flutter_application/features/customers/text_controls.dart';
import 'package:flutter_application/models/logo_model.dart';
import 'package:flutter_application/models/text_model.dart';

class LabelDesigner extends StatefulWidget {
  final String? labelSize;
  final String? labelDescription;
  final String? category;
  final Color backgroundColor;
  final String backgroundType;

  final ValueChanged<String> onBackgroundTypeChange;
  final ValueChanged<Color> onBackgroundColorChange;

  const LabelDesigner({
    super.key,
    required this.labelSize,
    required this.labelDescription,
    required this.category,
    required this.backgroundColor,
    required this.backgroundType,
    required this.onBackgroundTypeChange,
    required this.onBackgroundColorChange,
  });
  @override
  State<LabelDesigner> createState() => _LabelDesignerState();
}

class _LabelDesignerState extends State<LabelDesigner> {
  List<LogoElement> logos = [];
  String? selectedLogoId;
  List<TextElement> textElements = [];
  String? selectedTextId;
  final GlobalKey _previewKey = GlobalKey();
  Uint8List? previewImageBytes;

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
  void _moveLogo(String id, Offset delta) {
    setState(() {
      final logo = logos.firstWhere((l) => l.id == id);
      logo.x = (logo.x + delta.dx).clamp(0.0, 1.0);
      logo.y = (logo.y + delta.dy).clamp(0.0, 1.0);
    });
  }

  void _scaleLogo(double delta) {
    setState(() {
      final logo = logos.firstWhere((l) => l.id == selectedLogoId);
      logo.scale = (logo.scale + delta).clamp(0.1, 1.0);
    });
  }

  void _rotateLogo(double delta) {
    setState(() {
      final logo = logos.firstWhere((l) => l.id == selectedLogoId);
      logo.rotation += delta;
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
      selectedLogoId = null;
    });
  }

  void _updateText(String id, TextElement updated) {
    setState(() {
      final index = textElements.indexWhere((t) => t.id == id);
      textElements[index] = updated;
    });
  }

  void _deleteText(String id) {
    setState(() {
      textElements.removeWhere((t) => t.id == id);
      if (selectedTextId == id) selectedTextId = null;
    });
  }

  Future<void> _addLogoFromFile(File file) async {
    final provider = FileImage(file);
    final uiImage = await loadUiImage(provider);

    final logo = LogoElement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      image: uiImage,
    );

    setState(() {
      logos.add(logo);
      selectedLogoId = logo.id;
    });
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
              backgroundColor: widget.backgroundColor,
              backgroundType: widget.backgroundType,
              logos: logos,
              textElements: textElements,
              repaintKey: _previewKey,
              selectedLogoId: selectedLogoId,
              selectedTextId: selectedTextId,
              onMoveLogo: _moveLogo,
              onMoveText: _moveText,
            ),
          ),

          /// BACKGROUND CONTROLS
          _buildSection(
            title: 'Background',
            child: BackgroundControls(
              backgroundType: widget.backgroundType,
              backgroundColor: widget.backgroundColor,
              onBackgroundTypeChange: widget.onBackgroundTypeChange,
              onBackgroundColorChange: widget.onBackgroundColorChange,
            ),
          ),

          /// LOGO CONTROLS
          _buildSection(
            title: 'Logos',
            child: LogoControls(
              logos: logos,
              selectedLogoId: selectedLogoId,
              onPickLogo: _addLogoFromFile,
              onAddLogo: (logo) {
                setState(() {
                  logos.add(logo);
                  selectedLogoId = logo.id;
                });
              },
              onSelectLogo: (id) {
                setState(() {
                  selectedLogoId = id;
                });
              },
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
          )
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
