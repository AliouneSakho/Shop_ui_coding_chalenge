import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/auth_result.dart';
import 'package:plants_ui/state/auth/providers/auth_state_provider.dart';

final isLoadingProvider = StateProvider<bool>((ref) {
  final authProvider = ref.watch(authStateProvider);
  return authProvider.result == AuthResult.success;
});
