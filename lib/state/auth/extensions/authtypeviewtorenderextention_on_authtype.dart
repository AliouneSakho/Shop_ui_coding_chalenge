import 'package:flutter/widgets.dart' show Widget;
import 'package:plants_ui/state/auth/enums/auth_type.dart';
import 'package:plants_ui/state/exceptions/couldntfindviewforthisauthtype_exception.dart';
import 'package:plants_ui/ui/screens/auth/views/mail_password_auth_view.dart';
import 'package:plants_ui/ui/screens/auth/views/google_view.dart';

extension AuthTypeViewToRenderExtension on AuthType {
  Widget get viewToRender {
    switch (this) {
      case AuthType.google:
        return const GoogleAuthenticationView();
      case AuthType.mailAndPassword:
        return const MailPasswordAuthView();
      default:
        throw CouldNotFindViewForThisAuthType();
    }
  }
}
