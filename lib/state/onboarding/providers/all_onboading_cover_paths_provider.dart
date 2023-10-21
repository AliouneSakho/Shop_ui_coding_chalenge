import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:plants_ui/state/onboarding/constants/url_paths.dart';

final allOnboardingCoverPathsProvider = Provider<List<String>>((_) => [
      UrlPaths.coverPlant1,
      UrlPaths.coverPlant2,
      UrlPaths.coverPlant3,
    ]);
