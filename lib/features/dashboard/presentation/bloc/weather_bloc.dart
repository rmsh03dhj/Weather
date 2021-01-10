import 'package:bloc/bloc.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/app_start/domain/usecases/check_for_authentication_use_case.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_given_city_use_case.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_given_coordinates_use_case.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_user_current_location_use_case.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final fetchWeatherForCurrentLocationUseCase = sl<FetchWeatherForCurrentLocationUseCase>();
  final fetchWeatherForGivenCityUseCase = sl<FetchWeatherForGivenCityUseCase>();
  final fetchWeatherForGivenLocationUseCase = sl<FetchWeatherForGivenLocationUseCase>();

  WeatherBloc() : super(WeatherEmpty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherForCurrentLocation) {
      yield WeatherLoading();
      final failureOrWeather = await fetchWeatherForCurrentLocationUseCase.execute(NoParams());
      yield failureOrWeather.fold(
          (failure) => WeatherError(failure.failureMessage), (weather) => WeatherLoaded(weather));
    }
    if (event is FetchWeatherForGivenCity) {
      yield WeatherLoading();
      final failureOrWeather = await fetchWeatherForGivenCityUseCase
          .execute(FetchWeatherForGivenCityParams(event.cityName));
      yield failureOrWeather.fold(
          (failure) => WeatherError(failure.failureMessage), (weather) => WeatherLoaded(weather));
    }
    if (event is FetchWeatherForGivenLocation) {
      yield WeatherLoading();
      final failureOrWeather = await fetchWeatherForGivenLocationUseCase
          .execute(FetchWeatherForGivenLocationParams(event.position));
      yield failureOrWeather.fold(
          (failure) => WeatherError(failure.failureMessage), (weather) => WeatherLoaded(weather));
    }
  }
}
