import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/state/plant/typedefs/pot_type.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/componants/minicard_product.dart';
import 'package:plants_ui/ui/screens/home/componants/search_field.dart';

bool isKeyboardVisible(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  return mediaQuery.viewInsets.bottom > 0;
}

class SuggestionBoxWidget extends HookConsumerWidget {
  const SuggestionBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchInput = ref.watch(searchInputProvider);
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    );

    return Material(
      elevation: 7,
      borderRadius: borderRadius,
      child: Container(
        decoration: const BoxDecoration(borderRadius: borderRadius),
        child: AnimatedList(
          itemBuilder: (context, index, animation) {
            return const MiniCardProduct(
              plant: plant,
            );
          },
          initialItemCount: searchInput!.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

const plant = Plant(
  id: '1',
  plantName: 'Plant Jade',
  description:
      'Install our desktop application to drag and drop 1000s of images at once.',
  price: 12.55,
  imageUrls: [
    'https://firebasestorage.googleapis.com/v0/b/plantui-f9dc6.appspot.com/o/plant1.png?alt=media&token=68e4279c-32d6-4028-b721-53da73cb9176',
    'https://firebasestorage.googleapis.com/v0/b/plantui-f9dc6.appspot.com/o/jade1%20(1).png?alt=media&token=7ff7cff6-3fc8-4780-8e52-4a26ee298628',
  ],
  height: 5.5,
  temperature: 20.0,
  potType: PotType.ceramic,
);
