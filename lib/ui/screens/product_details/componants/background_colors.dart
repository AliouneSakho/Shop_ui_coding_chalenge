import 'package:flutter/material.dart';

class BackgroundColors extends StatelessWidget {
  const BackgroundColors({
    super.key,
    required this.colors,
    required this.backgroundColor,
  });

  final List<Color> colors;
  final ValueNotifier<Color> backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          ...colors.map(
            (color) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: color == backgroundColor.value
                    ? const EdgeInsets.all(4.0)
                    : EdgeInsets.zero,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () => backgroundColor.value = color,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
