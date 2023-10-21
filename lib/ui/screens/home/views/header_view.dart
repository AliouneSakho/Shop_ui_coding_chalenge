import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/screens/home/componants/profile_erea.dart';
import 'package:plants_ui/ui/screens/home/componants/search_field.dart';

class HeaderView extends ConsumerWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProfileErea(),
        SizedBox(height: 15),
        SearchField(),
      ],
    );
  }
}
