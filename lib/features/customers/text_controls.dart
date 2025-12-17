import 'package:flutter/material.dart';
import 'package:flutter_application/models/text_model.dart';

class TextControls extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final selected =
        texts.where((t) => t.id == selectedTextId).cast<TextElement?>().firstOrNull;

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
              onPressed: onAddText,
            ),
          ],
        ),

        /// TEXT LIST
        Wrap(
          spacing: 8,
          children: texts.map((t) {
            final selected = t.id == selectedTextId;
            return GestureDetector(
              onTap: () => onSelectText(t.id),
              child: Chip(
                label: Text(
                  t.text,
                  overflow: TextOverflow.ellipsis,
                ),
                backgroundColor:
                    selected ? Colors.blue.shade100 : Colors.grey.shade200,
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => onDeleteText(t.id),
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
              onUpdateText(selected.id, selected);
            },
            decoration: const InputDecoration(
              labelText: 'Text Content',
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  selected.fontSize =
                      (selected.fontSize - 2).clamp(8, 72);
                  onUpdateText(selected.id, selected);
                },
              ),
              Text('Size ${selected.fontSize.toInt()}'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  selected.fontSize =
                      (selected.fontSize + 2).clamp(8, 72);
                  onUpdateText(selected.id, selected);
                },
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.rotate_left),
                onPressed: () {
                  selected.rotation -= 0.1;
                  onUpdateText(selected.id, selected);
                },
              ),
              const Text('Rotate'),
              IconButton(
                icon: const Icon(Icons.rotate_right),
                onPressed: () {
                  selected.rotation += 0.1;
                  onUpdateText(selected.id, selected);
                },
              ),
            ],
          ),
        ],
      ],
    );
  }
}
