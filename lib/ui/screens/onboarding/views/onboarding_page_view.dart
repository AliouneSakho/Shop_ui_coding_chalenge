import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/onboarding/providers/onboarding_provider.dart';
import 'package:plants_ui/state/onboarding/providers/page_index_provider.dart';
import 'package:plants_ui/ui/componants/plant_carousel_slider.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/bottom_button_widget.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/dots_indicator.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/message_widget.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/skip_button.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/images_widget.dart';

class OnboardingPageView extends HookConsumerWidget {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final pageIndex = ref.watch(pageIndexProvider);
    final onboadingModel = ref.watch(onbordingProvider);
    final carouselViews = onboadingModel.urlPaths
        .map(
          (url) => ImagesWidget(
            imagePath: url,
            coverPath: onboadingModel.urlCovers[pageIndex],
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 7,
            child: Stack(
              children: [
                PlantCarouselSlider(
                  widgets: carouselViews,
                  pageController: pageController,
                  onPageChanged: (value) =>
                      ref.read(pageIndexProvider.notifier).onPageChanged(value),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SkipButton(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          AnimatedDotsIndicators(
            pageController: pageController,
            itemsLength: carouselViews.length,
          ),
          const SizedBox(height: 15.0),
          Flexible(
            flex: 3,
            child: MessageWidget(
              text: onboadingModel.messages[pageIndex],
            ),
          ),
          BottomButton(
            pageController: pageController,
            pagesLength: onboadingModel.messages.length,
          ),
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
