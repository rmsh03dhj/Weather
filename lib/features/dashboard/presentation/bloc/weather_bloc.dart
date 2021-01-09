import 'package:bloc/bloc.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_use_case.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final fetchWeatherUseCase = sl<FetchWeatherUseCase>();

  WeatherBloc() : super(WeatherEmpty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
        final failureOrWeather = await fetchWeatherUseCase.execute(
            FetchWeatherParams(event.cityName, event.latitude, event.longitude));
        yield failureOrWeather.fold(
                (failure) => WeatherError(failure.failureMessage),
                (weather) => WeatherLoaded(weather));
      }
    }
}
