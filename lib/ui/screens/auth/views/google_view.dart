import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleAuthenticationView extends ConsumerWidget {
  const GoogleAuthenticationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: const [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 30,
            ),
            SizedBox(width: 8),
            Text(
              'Privacy Notice',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Text(
          'By using this authentication methode, you grant permission to access and use the following information for providing a personalized experience:\n\n'
          '- Your profile photo: To personalize your user interface.\n\n'
          '- Your name: To address you properly and enhance user interactions.\n\n'
          '- Your email address: To communicate important information and updates related to the application.\n\n',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
