import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Domain contract — presentation talks only to this, never to Supabase.
/// Every fallible call returns `Either<Failure, T>` so errors are values,
/// not thrown exceptions.
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> signInWithFacebook();

  /// UI-only for now: navigates to the phone sheet, no backend call.
  Future<Either<Failure, void>> startPhoneSignIn(String phoneNumber);

  Future<Either<Failure, UserEntity?>> currentUser();
  Future<Either<Failure, void>> signOut();
  Stream<UserEntity?> authStateChanges();
}
