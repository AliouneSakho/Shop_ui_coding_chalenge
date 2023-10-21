import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/onboarding/providers/page_index_provider.dart';

class AnimatedDotsIndicators extends ConsumerWidget {
  final PageController pageController;
  final int itemsLength;
  final Color? color;
  const AnimatedDotsIndicators({
    super.key,
    required this.pageController,
    required this.itemsLength,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    const animationDuration = Duration(milliseconds: 300);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemsLength,
        (index) {
          double scaleFactor = 1.0;
          if (index == pageIndex) {
            scaleFactor = 3.0;
          }
          return GestureDetector(
            onTap: () {
              if (index != pageIndex) {
                pageController.animateToPage(
                  index,
                  duration: animationDuration,
                  curve: Curves.easeOut,
                );
              }
            },
            child: AnimatedContainer(
              duration: animationDuration,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              height: 10.0,
              width: 12.0 * scaleFactor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color ?? Theme.of(context).indicatorColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
