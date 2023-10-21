import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/text_trailing_bold.dart';

class MessageWidget extends HookConsumerWidget {
  final String text;

  const MessageWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    final slideAnimation = Tween(begin: const Offset(0, 0.2), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(
          animationController,
        );

    useEffect(
      () {
        animationController.forward(from: 0.0);
        return null;
      },
      [animationController, text],
    );

    return SlideTransition(
      position: slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: TextWithLastWordBold(
          message: text,
        ),
      ),
    );
  }
}
