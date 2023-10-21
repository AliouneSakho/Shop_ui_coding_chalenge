import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/typedefs/pot_type.dart';

extension PlantFilterValue on PlantFilter {
  String value({
    required double height,
    required double temperature,
    required PotType potType,
  }) {
    switch (this) {
      case PlantFilter.height:
        return '$height';
      case PlantFilter.temperature:
        return '$temperature';
      case PlantFilter.pot:
        return potType.name;
    }
  }
}
