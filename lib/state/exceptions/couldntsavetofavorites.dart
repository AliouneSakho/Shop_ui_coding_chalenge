import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotSaveToFavoritesException implements Exception {
  final message = ExceptionMessages.couldNotSaveToFavorites;

  CouldNotSaveToFavoritesException();
  @override
  String toString() => message;
}
