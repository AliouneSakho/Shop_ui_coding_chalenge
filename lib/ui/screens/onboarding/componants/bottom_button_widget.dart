import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/onboarding/providers/page_index_provider.dart';
import 'package:plants_ui/ui/custom_page_routes/fade_page_route.dart';
import 'package:plants_ui/ui/screens/onboarding/constants/strings.dart';
import 'package:plants_ui/ui/screens/auth/auth_screen.dart';

class BottomButton extends ConsumerWidget {
  final PageController pageController;
  final int pagesLength;
  const BottomButton({
    super.key,
    required this.pageController,
    required this.pagesLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);

    return GestureDetector(
      onTap: () {
        if (pageIndex < pagesLength - 1) {
          pageController.animateToPage(
            pageIndex + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
      child: AnimatedCrossFade(
        crossFadeState: pageIndex == pagesLength - 1
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(
          milliseconds: 300,
        ),
        firstChild: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).indicatorColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF737272).withOpacity(1),
                  offset: const Offset(1, 44),
                  blurRadius: 50,
                  spreadRadius: -3,
                ),
              ]),
          child: const Center(
            child: Icon(
              Icons.arrow_right_alt_sharp,
              color: Colors.white,
            ),
          ),
        ),
        secondChild: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            FadePageRoute(
              child: const AuthScreen(),
            ),
          ),
          child: const Text(
            Strings.getStarted,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
