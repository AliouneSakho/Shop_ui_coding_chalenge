import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/onboarding/typedefs/page_index.dart';

class PageIndexNotifier extends StateNotifier<PageIndex> {
  PageIndexNotifier() : super(0);
  void onPageChanged(int index) => state = index;
}
