import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/auth_type.dart';

final authTypeProvider = StateProvider<AuthType>((
  ref,
) {
  return AuthType.mailAndPassword;
});
