import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/ui/componants/circle_avatar_profile.dart';

class ProfileErea extends ConsumerWidget {
  const ProfileErea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        Spacer(),
        CircleAvatarProfile(
          diameter: 50,
          imageSource: AssetImage(UrlPaths.avatar),
        ),
      ],
    );
  }
}
