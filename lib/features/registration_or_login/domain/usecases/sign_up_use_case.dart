import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:weather/features/utils/constants/strings.dart';

import '../../../../core/usecases/base_use_case.dart';

abstract class SignUpUseCase implements BaseUseCase<User, SignUpParams> {}

class SignUpUseCaseImpl implements SignUpUseCase {
  final userRepository = sl<UserRepository>();

  @override
  Future<Either<Failure, User>> execute(SignUpParams signUpParams) async {
    try {
      final user = await userRepository.signUp(signUpParams.email, signUpParams.password);

      if (user != null) {
        return Right(user);
      } else {
        userRepository.getUser().delete();
        return Left(GeneralFailure(failureMessage: pleaseTryAgain));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({@required this.email, @required this.password});
}
