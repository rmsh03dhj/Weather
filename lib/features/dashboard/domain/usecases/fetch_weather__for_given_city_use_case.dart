import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:weather/features/registration_or_login/domain/usecases/base_use_case.dart';

abstract class FetchWeatherForGivenCityUseCase
    implements BaseUseCase<Weather, FetchWeatherForGivenCityParams> {}

class FetchWeatherForGivenCityUseCaseImpl implements FetchWeatherForGivenCityUseCase {
  final weatherRepository = sl<WeatherRepository>();
  @override
  Future<Either<Failure, Weather>> execute(
      FetchWeatherForGivenCityParams fetchWeatherForGivenCityParams) async {
    try {
      final weather = await weatherRepository.getWeather(fetchWeatherForGivenCityParams.cityName);
      return Right(weather);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class FetchWeatherForGivenCityParams {
  final String cityName;

  FetchWeatherForGivenCityParams(this.cityName);
}
