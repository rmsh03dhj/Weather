import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/core/services/weather_api_client.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather__for_given_city_use_case.dart';
import 'package:weather/features/registration_or_login/domain/usecases/base_use_case.dart';

abstract class FetchWeatherForGivenLocationUseCase
    implements BaseUseCase<Weather, FetchWeatherForGivenLocationParams> {}

class FetchWeatherForGivenLocationUseCaseImpl implements FetchWeatherForGivenLocationUseCase {
  final weatherApiClient = sl<WeatherApiClient>();
  final fetchWeatherForGivenCityUseCase = sl<FetchWeatherForGivenCityUseCase>();
  @override
  Future<Either<Failure, Weather>> execute(
      FetchWeatherForGivenLocationParams fetchWeatherForGivenLocationParams) async {
    try {
      final cityName = await weatherApiClient.getCityNameFromLocation(
          latitude: fetchWeatherForGivenLocationParams.position.latitude,
          longitude: fetchWeatherForGivenLocationParams.position.longitude);
      final failureOrWeather =
          await fetchWeatherForGivenCityUseCase.execute(FetchWeatherForGivenCityParams(cityName));
      return failureOrWeather.fold(
          (failure) => Left(GeneralFailure(failureMessage: failure.failureMessage)),
          (weather) => Right(weather));
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class FetchWeatherForGivenLocationParams {
  final Position position;

  FetchWeatherForGivenLocationParams(this.position);
}
