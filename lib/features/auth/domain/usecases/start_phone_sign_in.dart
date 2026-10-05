import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// Phone is UI-only in this slice: validates + opens the phone sheet,
/// performs no network / OTP logic yet.
class StartPhoneSignInUseCase {
  final AuthRepository repository;
  const StartPhoneSignInUseCase(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber) =>
      repository.startPhoneSignIn(phoneNumber);
}
