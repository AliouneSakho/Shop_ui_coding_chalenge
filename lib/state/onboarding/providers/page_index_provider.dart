import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;
import 'package:plants_ui/state/onboarding/notifiers/page_controller_notifier.dart';
import 'package:plants_ui/state/onboarding/typedefs/page_index.dart';

final pageIndexProvider = StateNotifierProvider<PageIndexNotifier, PageIndex>(
  (ref) => PageIndexNotifier(),
);
