import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotRemoveToCartException implements Exception {
  final message = ExceptionMessages.couldNotRemoveToCart;

  CouldNotRemoveToCartException();
  @override
  String toString() => message;
}
