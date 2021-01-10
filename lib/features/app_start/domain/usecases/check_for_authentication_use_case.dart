import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class CheckForAuthenticationUseCase implements BaseUseCase<User, NoParams> {}

class CheckForAuthenticationUseCaseImpl implements CheckForAuthenticationUseCase {
  final userRepository = sl<UserRepository>();

  @override
  Future<Either<Failure, User>> execute(NoParams noParams) async {
    try {
      final user = userRepository.getUser();
      return Right(user);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class NoParams {}
