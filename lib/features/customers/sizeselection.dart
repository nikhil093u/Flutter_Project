import 'package:flutter/material.dart';
import 'labelmodule.dart';

class SizeSelection extends StatelessWidget {
  final Function(String) onSizeSelect;
  final Function(String) sizeDescription;

  const SizeSelection({
    super.key,
    required this.onSizeSelect,
    required this.sizeDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Select Label Size',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Choose the vertical label size for your water bottles',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(height: 24),

          /// Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: labelSizes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // use 4 for tablet/web
              mainAxisSpacing: 26,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final size = labelSizes[index];

              return LayoutBuilder(
                builder: (context, constraints) {
                  final cellWidth = constraints.maxWidth;
                  final cellHeight = constraints.maxHeight;
                  final labelWidth = cellWidth * 0.35; // responsive
                  final labelHeight = cellHeight * 1; // responsive

                  return GestureDetector(
                    onTap: () {
                      onSizeSelect(size.id);
                      sizeDescription(size.description);
                      // print('Selected Size: ${size.name}');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: Column(
                        children: [
                          /// Label preview
                          Expanded(
                            child: Center(
                              child: Container(
                                width: labelWidth,
                                height: labelHeight,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  border: Border.all(
                                    color: Colors.blue.shade300,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    'LABEL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// Size info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.straighten,
                                size: 14,
                                color: Colors.blue.shade600,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  size.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          Text(
                            size.description,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),

                          const SizedBox(height: 6),

                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Vertical Label',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'W: ${size.width} mm',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  'H: ${size.height} mm',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
