import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

/// Remote auth contract implemented by [SupabaseAuthRemoteDataSource].
/// Presentation talks to the domain repository, never to this directly.
abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<UserModel?> currentUser();
  Future<void> signOut();
  Stream<UserModel?> authStateChanges();
}

/// Real Supabase-backed auth.
///
/// Facebook OAuth launches the provider's web flow; supabase_flutter observes
/// the [oauthRedirectUrl] deep link, exchanges the returned code for a session,
/// and emits it on [SupabaseClient.auth.onAuthStateChange] — which the
/// `AuthCubit` listens to. The launch call itself does not resolve a user.
class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  SupabaseAuthRemoteDataSource(this._client);

  /// Custom scheme registered in `AndroidManifest.xml` and `Info.plist`.
  static const String oauthRedirectUrl = 'tamen://oauth-callback';

  final SupabaseClient _client;

  @override
  Future<UserModel> signInWithGoogle() =>
      Future.error(UnimplementedError('Google sign-in not wired yet'));

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
  Future<void> signOut() => _client.auth.signOut();

  @override
  Stream<UserModel?> authStateChanges() =>
      _client.auth.onAuthStateChange.map((authState) {
        final user = authState.session?.user;
        return user == null ? null : UserModel.fromSupabaseUser(user);
      });
}
