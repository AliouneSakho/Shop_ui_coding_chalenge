import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useCallback, useState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';
import 'package:plants_ui/state/auth/providers/email_auth_type_provider.dart';
import 'package:plants_ui/state/auth/providers/login_fomkey_provider.dart';
import 'package:plants_ui/ui/screens/auth/componants/text_form_field_widget.dart';
import 'package:plants_ui/ui/screens/onboarding/constants/strings.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = useState(true);
    useCallback(() {
      ref.read(emailAuthTypeProvider.notifier).state = EmailAuthType.login;

      return null;
    });

    return Form(
      key: ref.watch(loginFormKeyProvider),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        shrinkWrap: true,
        primary: false,
        children: [
          TextFormFieldWidget(
            text: Strings.mail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.mail),
            validator: (value) {
              if (value == null || !value.endsWith('@gmail.com')) {
                return '   value sould end with @gmail.com';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          TextFormFieldWidget(
            text: Strings.password,
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(Icons.key_sharp),
            obscureText: isObscure.value,
            contentPadding: EdgeInsets.zero,
            suffixWidget: IconButton(
              icon: Icon(
                isObscure.value ? Icons.remove_red_eye : Icons.hide_source,
                color: Colors.white,
              ),
              onPressed: () => isObscure.value = !isObscure.value,
            ),
            validator: (value) {
              if (value == null || value.length <= 3) {
                return '   weak password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
