import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:plants_ui/state/onboarding/constants/url_paths.dart';

final allOnboardingImagePathsProvider = Provider<List<String>>((_) => [
      UrlPaths.plant1,
      UrlPaths.plant2,
      UrlPaths.plant3,
    ]);
