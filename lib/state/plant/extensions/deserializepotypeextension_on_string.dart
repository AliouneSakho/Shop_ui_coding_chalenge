import 'package:plants_ui/state/plant/typedefs/pot_type.dart';

extension DeserializePotTypeExtension on String {
  PotType potTypeFromJson() {
    return PotType.values.where((potType) => potType.name == this).first;
  }
}
