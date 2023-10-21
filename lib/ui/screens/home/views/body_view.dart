import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/home/componants/grid_item.dart';
import 'package:plants_ui/ui/screens/home/componants/suggestion_box.dart';

class BodyView extends ConsumerWidget {
  const BodyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = List.generate(
      20,
      (index) => Plant(
          id: index.toString(),
          plantName: plant.plantName,
          description: plant.description,
          price: plant.price,
          imageUrls: plant.imageUrls,
          height: plant.height,
          temperature: plant.temperature,
          potType: plant.potType),
    );

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 20.0,
        childAspectRatio: 0.55,
        mainAxisSpacing: 40.0,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        final plant = list[index];
        return GridItem(
          index: index,
          plant: plant,
        );
      },
    );
  }
}
