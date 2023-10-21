import 'package:flutter/material.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/extensions/plantfiltericonextension_on_plantfilter.dart';
import 'package:plants_ui/state/plant/extensions/plantfiltervalueextension_on_plantfilter.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/custom_page_routes/details_pop_up_card.dart';
import 'package:plants_ui/ui/custom_page_routes/hero_dialog_route.dart';

class MiniCardProduct extends StatelessWidget {
  final Plant plant;
  const MiniCardProduct({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Row(
                children: [
                  Image.network(
                    plant.imageUrls.first,
                    height: 70,
                    width: 80,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            plant.plantName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        '${plant.price} \$',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).indicatorColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Wrap(
                          children: [
                            ...PlantFilter.values.map(
                              (plantFilter) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      plantFilter.iconPath,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      plantFilter.value(
                                        height: plant.height,
                                        temperature: plant.temperature,
                                        potType: plant.potType,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
