import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SignInWithFacebookUseCase {
  final AuthRepository repository;
  const SignInWithFacebookUseCase(this.repository);

  Future<Either<Failure, void>> call() => repository.signInWithFacebook();
}
