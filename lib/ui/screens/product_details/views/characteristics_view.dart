import 'package:flutter/material.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/extensions/plantfiltericonextension_on_plantfilter.dart';
import 'package:plants_ui/state/plant/extensions/plantfiltervalueextension_on_plantfilter.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/componants/glassmorphism.dart';

class CharacteristicsView extends StatelessWidget {
  const CharacteristicsView({
    super.key,
    required this.plant,
  });

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Glassmorphism(
          borderWidht: 3,
          bottomColor: Colors.white54,
          upperColor: Colors.white24,
          widget: ListView(
            padding: const EdgeInsets.all(10.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Text(
                plant.plantName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...PlantFilter.values.map(
                    (filter) => Column(
                      children: [
                        Image.asset(
                          filter.iconPath,
                          height: 35,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          filter.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          filter.value(
                            height: plant.height,
                            temperature: plant.temperature,
                            potType: plant.potType,
                          ),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
