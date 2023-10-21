import 'package:flutter/material.dart';

class PlantCarouselSlider extends StatelessWidget {
  final PageController pageController;
  final List<Widget> widgets;
  final void Function(int)? onPageChanged;
  const PlantCarouselSlider({
    super.key,
    required this.pageController,
    required this.widgets,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      itemCount: widgets.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return widgets[index];
      },
    );
  }
}
