import 'package:plants_ui/state/plant/constants/plant_field_names.dart';
import 'package:plants_ui/state/plant/extensions/deserializepotypeextension_on_string.dart';
import 'package:plants_ui/state/plant/typedefs/pot_type.dart';

class Plant {
  final String id;
  final String plantName;
  final String description;
  final double price;
  final List<String> imageUrls;
  final double height;
  final double temperature;
  final PotType potType;

  const Plant({
    required this.id,
    required this.plantName,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.height,
    required this.temperature,
    required this.potType,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json[PlantFieldNames.palntId],
      plantName: json[PlantFieldNames.plantName],
      description: json[PlantFieldNames.description],
      price: json[PlantFieldNames.price].toDouble(),
      imageUrls: List.from(json[PlantFieldNames.imageUrls]),
      height: json[PlantFieldNames.height],
      temperature: json[PlantFieldNames.temperature],
      potType: (json[PlantFieldNames.potType] as String).potTypeFromJson(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PlantFieldNames.palntId: id,
      PlantFieldNames.plantName: plantName,
      PlantFieldNames.description: description,
      PlantFieldNames.price: price,
      PlantFieldNames.imageUrls: imageUrls,
      PlantFieldNames.height: height,
      PlantFieldNames.temperature: temperature,
      PlantFieldNames.potType: potType.name,
    };
  }
}
