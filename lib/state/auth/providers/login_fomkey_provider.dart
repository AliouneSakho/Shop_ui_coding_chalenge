import 'package:flutter/widgets.dart' show GlobalKey, FormState;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginFormKeyProvider = StateProvider<GlobalKey<FormState>>((_) {
  return GlobalKey<FormState>();
});
