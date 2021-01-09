import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';

abstract class BaseUseCase<TResult, TParams> {
  Future<Either<Failure, TResult>> execute(TParams params);
}
