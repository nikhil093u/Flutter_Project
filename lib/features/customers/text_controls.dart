import 'package:flutter/material.dart';
import 'package:flutter_application/models/text_model.dart';

class TextControls extends StatefulWidget {
  final List<TextElement> texts;
  final String? selectedTextId;
  final VoidCallback onAddText;
  final ValueChanged<String> onSelectText;
  final Function(String id, TextElement updated) onUpdateText;
  final ValueChanged<String> onDeleteText;

  const TextControls({
    super.key,
    required this.texts,
    required this.selectedTextId,
    required this.onAddText,
    required this.onSelectText,
    required this.onUpdateText,
    required this.onDeleteText,
  });
  @override
  State<TextControls> createState() => _TextControlsState();
}

class _TextControlsState extends State<TextControls> {
  bool isAdvancedOpen = false;
  @override
  Widget build(BuildContext context) {
    final selected = widget.texts
        .where((t) => t.id == widget.selectedTextId)
        .cast<TextElement?>()
        .firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Text Elements',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: widget.onAddText,
            ),
          ],
        ),

        /// TEXT LIST
        Wrap(
          spacing: 8,
          children: widget.texts.map((t) {
            final selected = t.id == widget.selectedTextId;
            return GestureDetector(
              onTap: () => widget.onSelectText(t.id),
              child: Chip(
                label: Text(t.text, overflow: TextOverflow.ellipsis),
                backgroundColor: selected
                    ? Colors.blue.shade100
                    : Colors.grey.shade200,
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => widget.onDeleteText(t.id),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        if (selected != null) ...[
          const Text('Edit Text'),

          TextField(
            controller: TextEditingController(text: selected.text),
            onChanged: (val) {
              selected.text = val;
              widget.onUpdateText(selected.id, selected.copyWith(text: val));
            },
            decoration: const InputDecoration(labelText: 'Text Content'),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  selected.fontSize = (selected.fontSize - 2).clamp(8, 72);
                  widget.onUpdateText(
                    selected.id,
                    selected.copyWith(
                      fontSize: (selected.fontSize - 2).clamp(8, 72),
                    ),
                  );
                },
              ),
              Text('Size ${selected.fontSize.toInt()}'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  widget.onUpdateText(
                    selected.id,
                    selected.copyWith(
                      fontSize: (selected.fontSize + 2).clamp(8, 72),
                    ),
                  );
                },
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.rotate_left),
                onPressed: () {
                  widget.onUpdateText(
                    selected.id,
                    selected.copyWith(rotation: selected.rotation - 0.1),
                  );
                },
              ),
              const Text('Rotate'),
              IconButton(
                icon: const Icon(Icons.rotate_right),
                onPressed: () {
                  widget.onUpdateText(
                    selected.id,
                    selected.copyWith(rotation: selected.rotation + 0.1),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          ExpansionTile(
            initiallyExpanded: isAdvancedOpen,
            onExpansionChanged: (v) {
              setState(() => isAdvancedOpen = v);
            },
            title: const Text(
              'Advanced Text Options',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            children: [
              /// FONT FAMILY
              _buildLabel('Font Family'),
              Wrap(
                spacing: 8,
                children: ['Poppins', 'Roboto', 'Inter'].map((font) {
                  return ChoiceChip(
                    label: Text(font, style: TextStyle(fontFamily: font)),
                    selected: selected.fontFamily == font,
                    onSelected: (_) {
                      widget.onUpdateText(
                        selected.id,
                        selected.copyWith(fontFamily: font),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              /// FONT WEIGHT
              _buildLabel('Font Weight'),
              Row(
                children: [
                  _chip('Normal', selected.fontWeight == FontWeight.normal, () {
                    widget.onUpdateText(
                      selected.id,
                      selected.copyWith(fontWeight: FontWeight.normal),
                    );
                  }),
                  const SizedBox(width: 8),
                  _chip('Bold', selected.fontWeight == FontWeight.bold, () {
                    widget.onUpdateText(
                      selected.id,
                      selected.copyWith(fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 12),

              /// OPACITY
              _buildLabel('Opacity'),
              Slider(
                value: selected.opacity,
                min: 0,
                max: 1,
                onChanged: (v) {
                  widget.onUpdateText(
                    selected.id,
                    selected.copyWith(opacity: v),
                  );
                },
              ),

              const SizedBox(height: 12),

              /// TEXT ALIGN
              _buildLabel('Text Align'),
              Row(
                children: [
                  _iconBtn(Icons.format_align_left, () {
                    widget.onUpdateText(
                      selected.id,
                      selected.copyWith(align: TextAlign.left),
                    );
                  }),
                  _iconBtn(Icons.format_align_center, () {
                    widget.onUpdateText(
                      selected.id,
                      selected.copyWith(align: TextAlign.center),
                    );
                  }),
                  _iconBtn(Icons.format_align_right, () {
                    widget.onUpdateText(
                      selected.id,
                      selected.copyWith(align: TextAlign.right),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 12),

              /// COLOR
              _buildLabel('Text Color'),
              GestureDetector(
                onTap: () {
                  // open color picker later
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selected.color,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _chip(String text, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(text),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return IconButton(icon: Icon(icon), onPressed: onTap);
  }
}
