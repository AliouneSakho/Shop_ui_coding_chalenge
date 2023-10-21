import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/backend/authenticator.dart';
import 'package:plants_ui/state/auth/enums/auth_result.dart';
import 'package:plants_ui/state/auth/models/auth_state.dart';
import 'package:plants_ui/state/user/methods/user_methods.dart';
import 'package:plants_ui/state/user/models/user.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserMethods();

  AuthStateNotifier() : super(const AuthState.unknown());

  Future<void> logOut() async {
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithMailAndPassword(
      emailAddress: email,
      password: password,
    );
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo();
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> createUserWithEmailPassword({
    required String name,
    String? urlPhoto,
    required String email,
    required String password,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.createWithMailAndPassword(
      emailAddress: email,
      password: password,
      userName: name,
      urlProfile: urlPhoto,
    );

    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo();
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> signingAnonymously() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signingAnonymously();

    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo();
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> saveUserInfo() {
    final user = User(
      id: _authenticator.userId!,
      userName: _authenticator.displayName,
      profileUrl: _authenticator.urlPhoto,
      favorites: [],
      cart: [],
    );

    return _userInfoStorage.saveUser(user);
  }
}
