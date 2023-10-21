import 'package:flutter/material.dart';

class AdaptiveCheckboxTileWidget extends StatelessWidget {
  final void Function(bool?) onChanged;
  final String text;
  final bool isActive;
  const AdaptiveCheckboxTileWidget({
    Key? key,
    required this.onChanged,
    required this.text,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox.adaptive(
          activeColor: Colors.greenAccent,
          shape: const CircleBorder(
            side: BorderSide(width: 2.0, color: Colors.white),
          ),
          side: const BorderSide(width: 2.0, color: Colors.white),
          value: isActive,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
