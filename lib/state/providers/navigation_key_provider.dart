import 'package:flutter/material.dart' show GlobalKey;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/screens/main/componants/navigation_bar.dart';

final navigationKeyProvider = StateProvider<GlobalKey<PlantNavigationBarState>>(
  (_) => GlobalKey<PlantNavigationBarState>(),
);
