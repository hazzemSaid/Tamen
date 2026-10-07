import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart' show Failure;
import '../../domain/entities/user_entity.dart';

/// Three visible screen states of the welcome flow:
/// [AuthInitial] (buttons), [AuthLoading] (progress), [AuthFailure]
/// (error banner + retry) — plus [AuthAuthenticated] for navigation.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Idle — shows Google / Facebook / Phone actions.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// A provider request is in flight — buttons disable, loader shows.
class AuthLoading extends AuthState {
  final AuthProvider provider;
  const AuthLoading(this.provider);

  @override
  List<Object?> get props => [provider];
}

/// Signed in — router navigates away from welcome.
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Provider failed — error banner + retry. Wraps a [Failure] value
/// (folded from `Either<Failure, T>`) instead of a raw string.
class AuthFailure extends AuthState {
  final Failure failure;
  final AuthProvider? provider;
  const AuthFailure(this.failure, {this.provider});

  /// Back-compat for UI that reads a plain message.
  String get message => failure.message;

  @override
  List<Object?> get props => [failure, provider];
}
