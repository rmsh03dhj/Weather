import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/app_start/domain/usecases/check_for_authentication_use_case.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_given_coordinates_use_case.dart';
import 'package:weather/features/registration_or_login/domain/usecases/base_use_case.dart';

abstract class FetchWeatherForCurrentLocationUseCase implements BaseUseCase<Weather, NoParams> {}

class FetchWeatherForCurrentLocationUseCaseImpl implements FetchWeatherForCurrentLocationUseCase {
  final fetchWeatherForGivenLocationUseCase = sl<FetchWeatherForGivenLocationUseCase>();
  final locationService = sl<LocationService>();
  @override
  Future<Either<Failure, Weather>> execute(NoParams noParams) async {
    try {
      final position = await locationService.getLocation();
      final failureOrWeather = await fetchWeatherForGivenLocationUseCase
          .execute(FetchWeatherForGivenLocationParams(position));
      return failureOrWeather.fold(
          (failure) => Left(GeneralFailure(failureMessage: failure.failureMessage)),
          (weather) => Right(weather));
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
