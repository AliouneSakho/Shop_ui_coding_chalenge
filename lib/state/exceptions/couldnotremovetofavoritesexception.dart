import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotRemoveToFavoritesException implements Exception {
  final message = ExceptionMessages.couldNotRemoveToFavorites;

  CouldNotRemoveToFavoritesException();
  @override
  String toString() => message;
}
