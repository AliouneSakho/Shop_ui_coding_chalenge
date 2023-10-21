import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/email_auth_type.dart';
import 'package:plants_ui/state/auth/providers/email_auth_type_provider.dart';
import 'package:plants_ui/state/auth/providers/signing_formkey.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/state/helpers/image_picker_herlper.dart';
import 'package:plants_ui/ui/componants/circle_avatar_profile.dart';
import 'package:plants_ui/ui/screens/auth/componants/text_form_field_widget.dart';
import 'package:plants_ui/ui/screens/onboarding/constants/strings.dart';

class SigningView extends HookConsumerWidget {
  const SigningView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSoure =
        useState<ImageProvider>(const AssetImage(UrlPaths.avatar));
    final isObscure = useState(true);
    useCallback(() {
      ref.read(emailAuthTypeProvider.notifier).state = EmailAuthType.signing;

      return null;
    });

    return Form(
      key: ref.watch(signingFormKeyProvider),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        shrinkWrap: true,
        primary: false,
        children: [
          Column(
            children: [
              CircleAvatarProfile(
                diameter: 90,
                imageSource: imageSoure.value,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () async {
                  final file = await ImagePickerHelper.pickImage();
                  if (file != null) {
                    imageSoure.value = file as ImageProvider;
                  }
                },
                label: const Text(
                  Strings.pickProfile,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
            text: Strings.name,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.person),
            validator: (value) {
              if (value == null || value.length <= 3) {
                return '   length should be more than 3';
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
