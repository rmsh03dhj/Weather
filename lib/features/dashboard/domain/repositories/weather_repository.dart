import 'package:weather/features/dashboard/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName, {double latitude, double longitude});
}
