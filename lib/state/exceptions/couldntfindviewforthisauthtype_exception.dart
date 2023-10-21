import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotFindViewForThisAuthType implements Exception {
  final message = ExceptionMessages.viewToRenderForThisAuthTypeNotFound;

  CouldNotFindViewForThisAuthType();
  @override
  String toString() => message;
}
