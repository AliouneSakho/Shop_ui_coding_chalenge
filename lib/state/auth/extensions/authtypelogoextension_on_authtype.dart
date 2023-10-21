import 'package:plants_ui/state/auth/enums/auth_type.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/state/exceptions/couldntfindlogoforthisauthtype_exception.dart';

extension AuthTypeLogoExtension on AuthType {
  String get logoPath {
    switch (this) {
      case AuthType.google:
        return UrlPaths.google3dLog;
      case AuthType.mailAndPassword:
        return UrlPaths.mail3dLog;
      default:
        throw CouldNotFindLogoForThisAuthType();
    }
  }
}
