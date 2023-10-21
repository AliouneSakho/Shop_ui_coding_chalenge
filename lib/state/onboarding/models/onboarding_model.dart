import 'package:flutter/foundation.dart' show immutable;

@immutable
class OnboardingModel {
  final List<String> urlPaths;
  final List<String> messages;
  final List<String> urlCovers;

  const OnboardingModel({
    required this.urlPaths,
    required this.messages,
    required this.urlCovers,
  }) : assert(
          urlPaths.length == messages.length &&
              messages.length == urlCovers.length,
        );
}
