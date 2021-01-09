import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/remote_config_service.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';

import 'service_locator.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  static String openWeatherApiKey = sl<RemoteConfigService>().weatherApiKey;
  final  httpClient = Client();

  WeatherApiClient();

  Future<String> getCityNameFromLocation({double latitude, double longitude}) async {
    try {
      final url = '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw HttpFailure(failureMessage: "Unable to fetch weather data.");
      }
      final weatherJson = json.decode(res.body);
      return weatherJson['name'];
    } catch (e) {
      throw GeneralFailure(failureMessage: "Something went wrong");
    }
  }

  Future<Weather> getWeatherData(String cityName) async {
    try {
      final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw HttpFailure(failureMessage: "Unable to fetch weather data.");
      }
      final weatherJson = json.decode(res.body);
      return Weather.fromJson(weatherJson);
    } catch (e) {
      throw GeneralFailure(failureMessage: "Something went wrong");
    }
  }

  Future<List<Weather>> getForecast(String cityName) async {
    try {
      final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw HttpFailure(failureMessage: "Unable to fetch weather data.");
      }
      final forecastJson = json.decode(res.body);
      List<Weather> weathers = Weather.fromForecastJson(forecastJson);
      return weathers;
    } catch (e) {
      throw GeneralFailure(failureMessage: "Something went wrong");
    }
  }
}
