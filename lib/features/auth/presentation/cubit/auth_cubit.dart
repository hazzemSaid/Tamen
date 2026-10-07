import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart' as failures;
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_with_facebook.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/start_phone_sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogleUseCase signInWithGoogle;
  final SignInWithFacebookUseCase signInWithFacebook;
  final StartPhoneSignInUseCase startPhoneSignIn;
  final GetCurrentUserUseCase getCurrentUser;
  final SignOutUseCase signOut;

  AuthCubit({
    required this.signInWithGoogle,
    required this.signInWithFacebook,
    required this.startPhoneSignIn,
    required this.getCurrentUser,
    required this.signOut,
  }) : super(const AuthInitial()) {
    _authSubscription = getCurrentUser.authStateChanges.listen(
      _handleAuthChange,
      onError: _handleAuthError,
    );
    _restoreSession();
  }

  StreamSubscription<UserEntity?>? _authSubscription;
  AppLifecycleListener? _lifecycleListener;
  bool _facebookSignInPending = false;

  Future<void> continueWithGoogle() async {
    emit(const AuthLoading(AuthProvider.google));
    final result = await signInWithGoogle();
    if (isClosed) return;
    result.fold(
      (failure) => failure.code == 'cancelled'
          ? emit(const AuthInitial())
          : emit(AuthFailure(failure, provider: AuthProvider.google)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> continueWithFacebook() async {
    _facebookSignInPending = true;
    emit(const AuthLoading(AuthProvider.facebook));
    final result = await signInWithFacebook();
    if (isClosed) return;
    result.fold(
      (failure) {
        _facebookSignInPending = false;
        emit(AuthFailure(failure, provider: AuthProvider.facebook));
      },
      (_) {
        _lifecycleListener?.dispose();
        _lifecycleListener = AppLifecycleListener(
          onResume: _restoreAfterOAuthReturn,
        );
      },
    );
  }

  Future<void> continueWithPhone(String phoneNumber) async {
    final result = await startPhoneSignIn(phoneNumber);
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(AuthFailure(failure, provider: AuthProvider.phone)),
      (_) {},
    );
  }

  void retry() => emit(const AuthInitial());

  Future<void> _restoreSession() async {
    final initialState = state;
    final result = await getCurrentUser();
    if (isClosed || !identical(state, initialState)) return;
    result.fold(
      _handleFailure,
      (user) {
        if (user != null) emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _restoreAfterOAuthReturn() async {
    final wasPending = _facebookSignInPending;
    _facebookSignInPending = false;
    _lifecycleListener?.dispose();
    _lifecycleListener = null;

    final result = await getCurrentUser();
    if (isClosed) return;
    result.fold(
      _handleFailure,
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else if (wasPending) {
          emit(const AuthInitial());
        }
      },
    );
  }

  void _handleAuthChange(UserEntity? user) {
    if (isClosed) return;
    if (user != null) {
      _facebookSignInPending = false;
      _lifecycleListener?.dispose();
      _lifecycleListener = null;
      emit(AuthAuthenticated(user));
    } else if (_facebookSignInPending) {
      emit(const AuthLoading(AuthProvider.facebook));
    } else {
      emit(const AuthInitial());
    }
  }

  void _handleAuthError(Object error, [StackTrace? stackTrace]) {
    if (isClosed) return;
    _facebookSignInPending = false;
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
    emit(AuthFailure(_toFailure(error)));
  }

  void _handleFailure(failures.Failure failure) {
    if (isClosed) return;
    _facebookSignInPending = false;
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
    emit(AuthFailure(failure));
  }

  failures.Failure _toFailure(Object error) {
    if (error is failures.Failure) return error;
    if (error is UnimplementedError) {
      return failures.AuthFailure(error.message ?? 'auth.errorGeneric');
    }
    return failures.AuthFailure(error.toString());
  }

  @override
  Future<void> close() async {
    _lifecycleListener?.dispose();
    await _authSubscription?.cancel();
    await super.close();
  }
}
