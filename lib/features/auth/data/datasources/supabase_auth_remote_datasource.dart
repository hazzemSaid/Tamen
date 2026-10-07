import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<UserModel?> currentUser();
  Future<void> signOut();
  Stream<UserModel?> authStateChanges();
}

class GoogleSignInCancelled implements Exception {
  const GoogleSignInCancelled();

  @override
  String toString() => 'GoogleSignInCancelled()';
}

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  SupabaseAuthRemoteDataSource(
    this._client, {
    GoogleSignIn? googleSignIn,
    String? googleServerClientId,
  }) : _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: const <String>['email', 'profile'],
              serverClientId: googleServerClientId,
            );

  static const String oauthRedirectUrl = 'tamen://oauth-callback';

  final SupabaseClient _client;
  final GoogleSignIn _googleSignIn;

  @override
  Future<UserModel> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) throw const GoogleSignInCancelled();

    final googleAuth = await account.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw StateError(
        'Google sign-in returned no idToken. '
        'Check GOOGLE_WEB_CLIENT_ID and the Android SHA-1 registration.',
      );
    }

    final response = await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuth.accessToken,
    );
    final user = response.user ?? _client.auth.currentUser;
    if (user == null) {
      throw StateError('Google sign-in failed: no Supabase session created.');
    }
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<void> signInWithFacebook() async {
    final launched = await _client.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: oauthRedirectUrl,
    );
    if (!launched) {
      throw StateError('Facebook sign-in could not be opened.');
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    final user = _client.auth.currentUser;
    return user == null ? null : UserModel.fromSupabaseUser(user);
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } finally {
      await _client.auth.signOut();
    }
  }

  @override
  Stream<UserModel?> authStateChanges() =>
      _client.auth.onAuthStateChange.map((authState) {
        final user = authState.session?.user;
        return user == null ? null : UserModel.fromSupabaseUser(user);
      });
}
