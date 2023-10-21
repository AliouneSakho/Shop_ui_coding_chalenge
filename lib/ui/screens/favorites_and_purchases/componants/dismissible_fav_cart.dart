import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/componants/minicard_product.dart';

class DissmissibleFvoriteCart extends HookWidget {
  const DissmissibleFvoriteCart({
    super.key,
    required this.plant,
  });

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    const double maxDragDistance = 100;
    final translationx = useState(0.0);
    final isTranlating = useState(false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.5),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: isTranlating.value ? const Color.fromRGBO(244, 67, 54, 1) : null,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  translationx.value = 0;
                  isTranlating.value = false;
                },
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragStart: (details) {
              isTranlating.value = true;
            },
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx < 0 &&
                  translationx.value > -maxDragDistance) {
                translationx.value += details.delta.dx;
              }
              if (details.delta.dx >= 0 &&
                  translationx.value == -maxDragDistance) {
                translationx.value = 0;
              }
            },
            onHorizontalDragEnd: (details) {
              if (translationx.value < -50) {
                translationx.value = -maxDragDistance;
              } else {
                translationx.value = 0;
                isTranlating.value = false;
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform: Matrix4.translationValues(
                translationx.value,
                0,
                0,
              ),
              child: MiniCardProduct(
                plant: plant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
