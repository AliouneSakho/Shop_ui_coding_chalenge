import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/helpers/pop_ups_helper.dart';
import 'package:plants_ui/state/onboarding/constants/url_paths.dart';
import 'package:plants_ui/state/onboarding/providers/page_index_provider.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/componants/plant_carousel_slider.dart';
import 'package:plants_ui/ui/screens/onboarding/componants/dots_indicator.dart';
import 'package:plants_ui/ui/screens/product_details/componants/background_colors.dart';
import 'package:plants_ui/ui/screens/product_details/views/characteristics_view.dart';

class ProductDetailScreen extends HookConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.plant,
  });
  final Plant plant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final widgets = [
      Image.asset(UrlPaths.plant1),
      Image.asset(UrlPaths.plant1),
    ];

    final colors = [
      Colors.green.shade300,
      Colors.orangeAccent,
      Colors.indigoAccent,
      Colors.red,
    ];
    final backgroundColor = useState(colors.first);

    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: backgroundColor.value,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            PlantCarouselSlider(
                              pageController: pageController,
                              onPageChanged: (value) => ref
                                  .read(pageIndexProvider.notifier)
                                  .onPageChanged(value),
                              widgets: widgets,
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(height: 10),
                                  BackgroundColors(
                                    colors: colors,
                                    backgroundColor: backgroundColor,
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              right: 40,
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: AnimatedDotsIndicators(
                                  pageController: pageController,
                                  itemsLength: widgets.length,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CharacteristicsView(plant: plant),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              plant.description,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 20,
          ),
          child: Wrap(
            children: [
              Column(
                children: [
                  Text(
                    'Price',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$${plant.price}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(width: 70),
              ElevatedButton(
                onPressed: () async {
                  final popupsInstance = PopUpsHandler.instance();
                  popupsInstance.showToastgOverlay(context);
                  await Future.delayed(const Duration(seconds: 1));
                  popupsInstance.hideToastOverlay();
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
