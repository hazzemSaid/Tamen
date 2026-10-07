import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;
  const SignInWithGoogleUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() =>
      repository.signInWithGoogle();
}
