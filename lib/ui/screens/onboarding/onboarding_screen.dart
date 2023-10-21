import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:plants_ui/ui/screens/onboarding/views/onboarding_page_view.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: Scaffold(
        body: OnboardingPageView(),
      ),
    );
  }
}
