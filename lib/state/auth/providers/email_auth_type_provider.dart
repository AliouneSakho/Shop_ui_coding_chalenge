import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';

final emailAuthTypeProvider = StateProvider<EmailAuthType>((_) {
  return EmailAuthType.signing;
});
