import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:plants_ui/state/constantes/firebase_collection_names.dart';
import 'package:plants_ui/state/constantes/firebase_instances.dart';
import 'package:plants_ui/state/methods/transformer_list.dart';
import 'package:plants_ui/state/plant/constants/plant_field_names.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/models/plant.dart';

@immutable
class PlantMethods {
  const PlantMethods();

  Stream<List<Plant>> fetchPlants() {
    return firestore
        .collection(FirebaseCollectionName.plants)
        .snapshots()
        .transform(transformerList(Plant.fromJson));
  }

  Stream<List<Plant>> fetchPlantsByFilter({
    required PlantFilter plantFilter,
    required dynamic value,
  }) {
    final ref = firestore.collection(FirebaseCollectionName.plants);
    late Query query;
    if (plantFilter == PlantFilter.pot) {
      query = ref.where(
        PlantFieldNames.potType,
        isEqualTo: value,
      );
    } else {
      query = ref.orderBy(plantFilter.name);
    }

    return query.snapshots().transform(transformerList(Plant.fromJson));
  }

  Future<Plant> fetchPlantById({
    required String id,
  }) async {
    return await firestore
        .collection(FirebaseCollectionName.plants)
        .where(PlantFieldNames.palntId, isEqualTo: id)
        .limit(1)
        .get()
        .then(
          (value) => Plant.fromJson(
            value.docs.first.data(),
          ),
        );
  }
}
