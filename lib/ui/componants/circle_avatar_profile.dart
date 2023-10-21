import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/image_upload/providers/right_image_provider.dart';
import 'package:plants_ui/state/image_upload/typedefs/image_provider.dart';

class CircleAvatarProfile extends ConsumerWidget {
  final double diameter;
  final ImageSource imageSource;
  const CircleAvatarProfile({
    super.key,
    required this.diameter,
    required this.imageSource,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        image: DecorationImage(
          image: ref.watch(imageProvider(imageSource)),
          fit: BoxFit.contain,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
