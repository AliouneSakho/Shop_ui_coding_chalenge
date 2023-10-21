import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';
import 'package:plants_ui/state/auth/notifiers/mail_and_password_auth_validation_notifier.dart';
import 'package:plants_ui/state/auth/providers/email_auth_type_provider.dart';
import 'package:plants_ui/state/auth/providers/login_fomkey_provider.dart';
import 'package:plants_ui/state/auth/providers/signing_formkey.dart';

final mailAndPasswordAuthenticationValidatorProvider =
    StateNotifierProvider<MailAndPasswordAuthenticationValidatorNotifier, bool>(
        (ref) {
  final mailAuthType = ref.watch(emailAuthTypeProvider);
  final formKey = ref.watch(
    mailAuthType == EmailAuthType.login
        ? loginFormKeyProvider
        : signingFormKeyProvider,
  );
  return MailAndPasswordAuthenticationValidatorNotifier(formKey);
});
