import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserFieldNames {
  static const String userId = 'id';
  static const String userName = 'userName';
  static const String profileUrl = 'profileUrl';
  static const String favorites = 'favorites';
  static const String cart = 'cart';

  const UserFieldNames._();
}
