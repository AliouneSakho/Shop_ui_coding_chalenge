import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/componants/purchase_cart.dart';
import 'package:plants_ui/ui/screens/home/componants/suggestion_box.dart';

class PurchasesView extends ConsumerWidget {
  const PurchasesView({super.key});

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

    return AnimatedList(
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index, animation) {
        return PurchaseCard(
          plant: list[index],
        );
      },
      initialItemCount: list.length,
    );
  }
}
