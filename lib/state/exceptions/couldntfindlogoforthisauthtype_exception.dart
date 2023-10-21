import 'package:plants_ui/state/constantes/error_messages.dart';

class CouldNotFindLogoForThisAuthType implements Exception {
  final message = ExceptionMessages.couldNotLogoForThisAuthType;

  CouldNotFindLogoForThisAuthType();
  @override
  String toString() => message;
}
