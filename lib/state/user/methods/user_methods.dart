import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:plants_ui/state/constantes/firebase_collection_names.dart';
import 'package:plants_ui/state/constantes/firebase_instances.dart';
import 'package:plants_ui/state/exceptions/couldnotremovetocartexception.dart';
import 'package:plants_ui/state/exceptions/couldnotremovetofavoritesexception.dart';
import 'package:plants_ui/state/exceptions/couldnotsavetocartexception.dart';
import 'package:plants_ui/state/exceptions/couldntsavetofavorites.dart';
import 'package:plants_ui/state/methods/transformer.dart';
import 'package:plants_ui/state/plant/methods/plant_methods.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/state/user/constants/user_field_names.dart';
import 'package:plants_ui/state/user/models/user.dart';

@immutable
class UserMethods {
  const UserMethods();

  Future saveUser(User user) async {
    await firestore
        .collection(FirebaseCollectionName.users)
        .doc(user.id)
        .set(user.toJson());
  }

  Future<User?> fetchUserCredentials() async {
    return await firestore
        .collection(FirebaseCollectionName.users)
        .doc(auth.currentUser?.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        return User.fromJson(doc.data()!);
      } else {
        return null;
      }
    });
  }

  Stream<User?> fetchUserStreamCredentials() {
    return firestore
        .collection(FirebaseCollectionName.users)
        .doc(auth.currentUser?.uid)
        .snapshots()
        .transform(transformer(User.fromJson));
  }

  Stream<List<Plant>?> fetchUserFavorites() {
    final controller = StreamController<List<Plant>>();
    final sub = fetchUserStreamCredentials().listen((user) {
      final List<Plant> plants = [];
      user?.favorites.map((id) async {
        final plant = await const PlantMethods().fetchPlantById(id: id);
        plants.add(plant);
      });
      controller.sink.add(plants);
    });

    sub.cancel();
    controller.close();
    return controller.stream;
  }

  Stream<List<Plant>?> fetchUserCrat() {
    final controller = StreamController<List<Plant>>();
    final sub = fetchUserStreamCredentials().listen((user) {
      final List<Plant> plants = [];
      user?.cart.map((id) async {
        final plant = await const PlantMethods().fetchPlantById(id: id);
        plants.add(plant);
      });
      controller.sink.add(plants);
    });

    sub.cancel();
    controller.close();
    return controller.stream;
  }

  Future fetchPurchases() {
    return firestore
        .collection(FirebaseCollectionName.purchases)
        .where('purchaserId', isEqualTo: auth.currentUser?.uid)
        .get()
        .then((value) {
      return value.docs.map((doc) {
        // return PurchaseModel.fromJson(doc.data());
      });
    });
  }

  void addFavorite({
    required String plantId,
    required String userId,
  }) {
    try {
      firestore.collection(FirebaseCollectionName.users).doc(userId).update(
        {
          UserFieldNames.favorites: FieldValue.arrayUnion([plantId]),
        },
      );
    } catch (_) {
      CouldNotSaveToFavoritesException();
    }
  }

  void removeToFavorite({
    required String plantId,
    required String userId,
  }) {
    try {
      firestore.collection(FirebaseCollectionName.users).doc(userId).update(
        {
          UserFieldNames.favorites: FieldValue.arrayRemove([plantId]),
        },
      );
    } catch (_) {
      CouldNotRemoveToFavoritesException();
    }
  }

  void addToCart({
    required String plantId,
    required String userId,
  }) {
    try {
      firestore.collection(FirebaseCollectionName.users).doc(userId).update(
        {
          UserFieldNames.cart: FieldValue.arrayUnion([plantId]),
        },
      );
    } catch (_) {
      CouldNotSaveToCartException();
    }
  }

  void removeToCart({
    required String plantId,
    required String userId,
  }) {
    try {
      firestore.collection(FirebaseCollectionName.users).doc(userId).update(
        {
          UserFieldNames.cart: FieldValue.arrayRemove([plantId]),
        },
      );
    } catch (_) {
      CouldNotRemoveToCartException();
    }
  }
}
