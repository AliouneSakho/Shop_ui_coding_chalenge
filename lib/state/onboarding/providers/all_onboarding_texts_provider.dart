import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:plants_ui/state/onboarding/constants/strings.dart';

final allOnboardingTextsProvider = Provider<List<String>>((_) => [
      Strings.enjoyYourLifeWithPlants,
      Strings.exploreTheUniverseOfFlavorsWithOurRecipes,
      Strings.transformYourRoutineWithMindfulMeditation,
    ]);
