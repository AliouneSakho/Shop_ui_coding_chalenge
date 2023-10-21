import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:plants_ui/state/onboarding/models/onboarding_model.dart';
import 'package:plants_ui/state/onboarding/providers/all_onboading_cover_paths_provider.dart';
import 'package:plants_ui/state/onboarding/providers/all_onboarding_image_paths_provider.dart';
import 'package:plants_ui/state/onboarding/providers/all_onboarding_texts_provider.dart';

final onbordingProvider = Provider<OnboardingModel>(
  (ref) {
    final urlPaths = ref.watch(allOnboardingImagePathsProvider);
    final messages = ref.watch(allOnboardingTextsProvider);
    final urlCovers = ref.watch(allOnboardingCoverPathsProvider);

    return OnboardingModel(
      urlPaths: urlPaths,
      messages: messages,
      urlCovers: urlCovers,
    );
  },
);
