import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotSaveToCartException implements Exception {
  final message = ExceptionMessages.couldNotSaveToYourCart;

  CouldNotSaveToCartException();
  @override
  String toString() => message;
}
