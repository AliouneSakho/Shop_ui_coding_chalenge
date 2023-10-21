import 'package:flutter/material.dart';

class TextWithLastWordBold extends StatelessWidget {
  final String message;
  const TextWithLastWordBold({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = message.trim().split(' ');
    final String textWithoutLastWord =
        words.sublist(0, words.length - 1).join(' ');
    final String lastWord = ' ${words.last}';

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
        children: <TextSpan>[
          TextSpan(text: textWithoutLastWord),
          TextSpan(
            text: lastWord,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
