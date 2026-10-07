import 'package:dartz/dartz.dart';
import 'package:tamen/core/error/failures.dart';
import 'package:tamen/features/auth/data/datasources/supabase_auth_remote_datasource.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  const AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await remote.signInWithGoogle();
      return Right(user);
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithFacebook() async {
    try {
      await remote.signInWithFacebook();
      return const Right(null);
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> startPhoneSignIn(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      return const Left(AuthFailure('Phone number must not be empty'));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity?>> currentUser() async {
    try {
      final user = await remote.currentUser();
      return Right(user);
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remote.signOut();
      return const Right(null);
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() => remote.authStateChanges();

  Failure _toFailure(Object error) {
    if (error is Failure) return error;
    if (error is GoogleSignInCancelled) {
      return const AuthFailure('auth.cancelled', code: 'cancelled');
    }
    if (error is UnimplementedError) {
      return AuthFailure(error.message ?? 'auth.errorGeneric');
    }
    if (error is StateError) {
      return AuthFailure(error.message);
    }
    return AuthFailure(error.toString());
  }
}
