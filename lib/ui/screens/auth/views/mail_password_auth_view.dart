import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';
import 'package:plants_ui/state/auth/providers/email_auth_type_provider.dart';
import 'package:plants_ui/ui/screens/auth/views/loging_view.dart';
import 'package:plants_ui/ui/screens/auth/views/signing_view.dart';

class MailPasswordAuthView extends ConsumerWidget {
  const MailPasswordAuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewToRender = ref.watch(emailAuthTypeProvider);

    return AnimatedCrossFade(
      firstChild: const LoginView(),
      secondChild: const SigningView(),
      crossFadeState: authViewToRender == EmailAuthType.login
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}
