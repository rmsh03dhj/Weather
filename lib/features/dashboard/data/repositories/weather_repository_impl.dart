import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:weather/core/services/weather_api_client.dart';
import 'package:weather/features/utils/constants/strings.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final weatherApiClient = sl<WeatherApiClient>();

  WeatherRepositoryImpl();

  @override
  Future<Weather> getWeather(String cityName, {double latitude, double longitude}) async {
    try {
      var weather = await weatherApiClient.getWeatherData(cityName);
      var weathers = await weatherApiClient.getForecast(cityName);
      weather.forecast = weathers;
      return weather;
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }
}
