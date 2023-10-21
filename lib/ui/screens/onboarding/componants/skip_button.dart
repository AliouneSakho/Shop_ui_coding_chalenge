import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/custom_page_routes/fade_page_route.dart';
import 'package:plants_ui/ui/screens/onboarding/constants/strings.dart';
import 'package:plants_ui/ui/screens/auth/auth_screen.dart';

class SkipButton extends ConsumerWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        FadePageRoute(
          child: const AuthScreen(),
        ),
      ),
      child: const Text(
        Strings.skip,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
    );
  }
}
