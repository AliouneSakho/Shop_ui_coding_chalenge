import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/auth_type.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';
import 'package:plants_ui/state/auth/providers/auth_state_provider.dart';
import 'package:plants_ui/state/auth/providers/auth_type_provider.dart';
import 'package:plants_ui/state/auth/providers/email_auth_type_provider.dart';
import 'package:plants_ui/state/auth/providers/mail_and_password_auth_validation.dart';
import 'package:plants_ui/state/helpers/pop_ups_helper.dart';
import 'package:plants_ui/state/onboarding/constants/url_paths.dart';
import 'package:plants_ui/state/onboarding/providers/page_index_provider.dart';
import 'package:plants_ui/ui/componants/glassmorphism.dart';
import 'package:plants_ui/ui/screens/auth/componants/adaptive_checkbox_tile_widget.dart';
import 'package:plants_ui/ui/screens/auth/componants/tab_widget.dart';
import 'package:plants_ui/ui/screens/main/main_screen.dart';
import 'package:plants_ui/ui/screens/onboarding/constants/strings.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSigningWithMail =
        ref.watch(emailAuthTypeProvider) == EmailAuthType.signing;
    bool isLoginWithMail =
        ref.watch(emailAuthTypeProvider) == EmailAuthType.login;
    bool isLoginWithMailAndPassword =
        ref.watch(authTypeProvider) == AuthType.mailAndPassword;
    final isFormValid =
        ref.watch(mailAndPasswordAuthenticationValidatorProvider);

    final height = useState(450.0);

    useEffect(() {
      if (isLoginWithMailAndPassword && isSigningWithMail) {
        if (isFormValid) {
          height.value = 470.0;
        } else {
          height.value = 550.0;
        }
      } else if (isLoginWithMailAndPassword && isLoginWithMail) {
        if (isFormValid) {
          height.value = 230.0;
        } else {
          height.value = 290.0;
        }
      } else {
        height.value = 470.0;
      }
      return null;
    }, [
      isLoginWithMailAndPassword,
      isSigningWithMail,
      isLoginWithMail,
      isFormValid,
    ]);

    final authStateNotifier = ref.read(authStateProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(UrlPaths.authViewCover),
            ),
          ),
          child: Glassmorphism(
            widget: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                      maxHeight: height.value,
                      minHeight: 200,
                      minWidth: double.maxFinite,
                    ),
                    child: const TabWidget(),
                  ),
                  if (isLoginWithMailAndPassword)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdaptiveCheckboxTileWidget(
                          text: Strings.signing,
                          onChanged: (value) {
                            if (!isSigningWithMail) {
                              ref.read(emailAuthTypeProvider.notifier).state =
                                  EmailAuthType.signing;
                            }
                          },
                          isActive: isSigningWithMail,
                        ),
                        const SizedBox(
                            width: 5), // Espacement entre les cases à cocher
                        AdaptiveCheckboxTileWidget(
                          text: Strings.login,
                          onChanged: (value) {
                            if (!isLoginWithMail) {
                              ref.read(emailAuthTypeProvider.notifier).state =
                                  EmailAuthType.login;
                            }
                          },
                          isActive: isLoginWithMail,
                        ),
                      ],
                    ),
                  const Divider(
                    thickness: 5,
                    color: Colors.grey,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final popupsInstance = PopUpsHandler.instance();
                        popupsInstance.showProcessingOverlay(context);
                        await Future.delayed(const Duration(seconds: 3));
                        popupsInstance.hideProcessingOverlay();
                        if (context.mounted) {
                          Navigator.of(context)
                              .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const MainScreen(),
                                ),
                                (route) => false,
                              )
                              .then(
                                (_) => ref.refresh(pageIndexProvider),
                              );
                        }
                      },
                      child: Text(
                        Strings.continueAsGuest,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue.shade200,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.error,
                            ),
                            elevation: MaterialStateProperty.all<double>(12.0),
                            shadowColor: MaterialStateProperty.all<Color>(
                              Colors.red,
                            ),
                          ),
                          child: const Text(
                            Strings.cancel,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            ref
                                .read(
                                  mailAndPasswordAuthenticationValidatorProvider
                                      .notifier,
                                )
                                .validateForm();
                            final authType = ref.watch(authTypeProvider);
                            if (isFormValid) {
                              final popupsInstance = PopUpsHandler.instance();
                              popupsInstance.showProcessingOverlay(context);
                              await Future.delayed(const Duration(seconds: 3));
                              popupsInstance.hideProcessingOverlay();
                              if (context.mounted) {
                                Navigator.of(context)
                                    .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => const MainScreen(),
                                      ),
                                      (route) => false,
                                    )
                                    .then(
                                      (_) => ref.refresh(pageIndexProvider),
                                    );
                              }
                              // switch (authType) {
                              //   case AuthType.mailAndPassword:
                              //     switch (ref.watch(emailAuthTypeProvider)) {
                              //       case EmailAuthType.login:

                              //             authStateNotifier.loginWithEmailPassword(
                              //               email: email,
                              //               password: password,
                              //             );
                              //       case EmailAuthType.signing:
                              //       authStateNotifier
                              //             .createUserWithEmailPassword(
                              //               name: ,
                              //               password: ,
                              //               urlPhoto: ,
                              //               email: ,
                              //             );
                              //     }
                              //     break;
                              //   case AuthType.google:
                              //     authStateNotifier.loginWithGoogle();
                              //     break;
                              //   case AuthType.guest:
                              //   authStateNotifier.signingAnonymously();
                              //     break;
                              // }
                            }
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(12.0),
                            shadowColor: MaterialStateProperty.all<Color>(
                              Colors.tealAccent,
                            ),
                          ),
                          child: const Text(
                            Strings.connexion,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: isLoginWithMail ? 100 : 20,
            ),
          ),
        ),
      ),
    );
  }
}
