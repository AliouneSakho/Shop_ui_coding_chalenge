import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plants_ui/state/auth/enums/auth_result.dart';
import 'package:plants_ui/state/auth/typedefs/user_id.dart';
import 'package:plants_ui/state/constantes/firebase_instances.dart';
import 'package:plants_ui/state/constantes/strings.dart';
import 'package:plants_ui/state/image_upload/typedefs/image_provider.dart';

class Authenticator {
  const Authenticator();

  bool get isAlreadyLoggedIn => userId != null;
  UserId? get userId => auth.currentUser?.uid;
  String get displayName => auth.currentUser?.displayName ?? '';
  String? get email => auth.currentUser?.email;
  Url? get urlPhoto => auth.currentUser?.photoURL ?? '';

  Future<void> logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Strings.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await auth.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } catch (_) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithMailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return AuthResult.success;
    } catch (_) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signingAnonymously() async {
    try {
      await auth.signInAnonymously();
      return AuthResult.success;
    } catch (_) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> createWithMailAndPassword({
    required String userName,
    required String emailAddress,
    required String password,
    String? urlProfile,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await result.user?.updateDisplayName(userName);
      if (urlProfile != null) {
        await result.user?.updateDisplayName(urlProfile);
      }

      return AuthResult.success;
    } catch (_) {
      return AuthResult.failure;
    }
  }
}
