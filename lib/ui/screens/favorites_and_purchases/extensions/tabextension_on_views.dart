import 'package:flutter/material.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/enums/views.dart';

extension TabExtension on Views {
  Widget tab(
    BuildContext context, {
    required bool isSelected,
    required Color indicatorColor,
    required BorderRadiusGeometry borderRadius,
  }) {
    final borderColor = isSelected ? indicatorColor : Colors.black;
    switch (this) {
      case Views.favorites:
        return Tab(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: borderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: isSelected ? Colors.white : null,
                ),
                const SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),
        );
      case Views.purchases:
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                color: isSelected ? Colors.white : null,
              ),
              const SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                ),
              ),
            ],
          ),
        );
    }
  }
}
