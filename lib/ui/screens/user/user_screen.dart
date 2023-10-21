import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/ui/componants/circle_avatar_profile.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          const Center(
            child: CircleAvatarProfile(
              diameter: 220,
              imageSource: AssetImage(UrlPaths.avatar),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Alioune Sakho',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 70),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '25',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.shopping_cart_outlined),
                  ],
                ),
                Divider(
                  height: 10,
                  thickness: 20,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      '25',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.favorite_outline),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
