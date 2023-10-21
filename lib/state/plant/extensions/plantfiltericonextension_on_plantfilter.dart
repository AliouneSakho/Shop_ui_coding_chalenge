import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';

extension PlantFilterIconPathExtension on PlantFilter {
  String get iconPath {
    switch (this) {
      case PlantFilter.height:
        return UrlPaths.height;
      case PlantFilter.pot:
        return UrlPaths.pot;
      case PlantFilter.temperature:
        return UrlPaths.temperature;

      default:
        throw Exception();
    }
  }
}
