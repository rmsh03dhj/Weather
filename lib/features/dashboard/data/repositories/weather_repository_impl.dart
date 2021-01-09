import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:weather/core/services/weather_api_client.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final weatherApiClient = sl<WeatherApiClient>();
  final locationService = sl<LocationService>();

  WeatherRepositoryImpl();

  @override
  Future<Weather> getWeather(String cityName, {double latitude, double longitude}) async {
    if (cityName == null || cityName.isEmpty) {
      if (latitude == null || longitude == null) {
        final position = await locationService.getLocation();
        cityName = await weatherApiClient.getCityNameFromLocation(
            latitude: position.latitude, longitude: position.longitude);
      } else {
        cityName = await weatherApiClient.getCityNameFromLocation(
            latitude: latitude, longitude: longitude);
      }
    }
    var weather = await weatherApiClient.getWeatherData(cityName);
    var weathers = await weatherApiClient.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}
