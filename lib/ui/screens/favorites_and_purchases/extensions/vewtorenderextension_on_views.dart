import 'package:flutter/material.dart' show Widget;
import 'package:plants_ui/ui/screens/favorites_and_purchases/enums/views.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/views/favorites_view.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/views/purchases_view.dart';

extension ViewToRenderExtension on Views {
  Widget get viewToRender {
    switch (this) {
      case Views.favorites:
        return const FavoritesView();
      case Views.purchases:
        return const PurchasesView();
    }
  }
}
