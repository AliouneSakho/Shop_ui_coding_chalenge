import 'package:flutter/material.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/product_details/product_screen.dart';

import 'custom_rect_tween.dart';

class DetailsPopupCard extends StatelessWidget {
  const DetailsPopupCard({
    Key? key,
    required this.plant,
  }) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final String heroTag = plant.id;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
          child: Hero(
            transitionOnUserGestures: true,
            tag: heroTag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return Material(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ProductDetailScreen(
                  plant: plant,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
