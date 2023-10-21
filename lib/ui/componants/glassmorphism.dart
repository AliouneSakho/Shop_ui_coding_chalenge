import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

class Glassmorphism extends StatelessWidget {
  final Widget widget;
  final EdgeInsetsGeometry? margin;
  final Color bottomColor;
  final Color upperColor;
  final double sigmaX;
  final double sigmaY;
  final double borderWidht;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  const Glassmorphism({
    super.key,
    this.margin,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.sigmaX = 5,
    this.sigmaY = 5,
    this.bottomColor = Colors.white24,
    this.upperColor = Colors.white10,
    this.borderWidht = 1.5,
    this.borderColor,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    return buildBlur(
      borderRadius: radius,
      sigmaX: sigmaX,
      sigmaY: sigmaY,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              bottomColor,
              upperColor,
            ],
          ),
          border: Border.all(
            width: borderWidht,
            color: borderColor ?? Colors.grey.shade100,
          ),
        ),
        child: widget,
      ),
    );
  }
}

Widget buildBlur({
  required Widget child,
  required BorderRadius borderRadius,
  required double sigmaX,
  required double sigmaY,
}) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: child,
    ),
  );
}
