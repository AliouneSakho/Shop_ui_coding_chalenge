import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/helpers/pop_ups_helper.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/custom_page_routes/details_pop_up_card.dart';
import 'package:plants_ui/ui/custom_page_routes/hero_dialog_route.dart';

class GridItem extends HookConsumerWidget {
  final Plant plant;
  final int index;

  const GridItem({
    super.key,
    required this.plant,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isLiked = useState(false);
    double offset = index.isOdd ? 0 : 40.0;
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final animation = Tween<double>(begin: 1, end: pi / 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    useEffect(
      () {
        animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.reverse();
          }
        });
        return null;
      },
      [animationController],
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              return DetailsPopupCard(
                plant: plant,
              );
            },
          ),
        );
      },
      child: Hero(
        transitionOnUserGestures: true,
        tag: plant.id,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: theme.indicatorColor.withOpacity(0.6),
                    offset: const Offset(0, 2),
                    blurRadius: 11,
                    spreadRadius: -2,
                  ),
                ]),
            transform: Matrix4.translationValues(0.0, offset, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Image.network(plant.imageUrls.first),
                  ),
                  Text(
                    plant.plantName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${plant.price}',
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            isLiked.value = !isLiked.value;
                            if (isLiked.value) {
                              animationController.forward().then(
                                    (value) => PopUpsHandler.instance()
                                        .savedToCollectionToast(
                                      context,
                                      imageUrl: plant.imageUrls.first,
                                      text: 'Added to your favorites',
                                    ),
                                  );
                            }
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (context, child) {
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..scale(animation.value),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 21,
                                    color: isLiked.value
                                        ? Colors.green.shade300
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
