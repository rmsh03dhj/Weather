import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather/core/services/remote_config_service.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/utils/constants/strings.dart';

import 'service_locator.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  static String openWeatherApiKey = sl<RemoteConfigService>().weatherApiKey;
  final httpClient = Client();

  WeatherApiClient();

  Future<String> getCityNameFromLocation({double latitude, double longitude}) async {
    try {
      final url = '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw errorMessageUnableToFetchData;
      }
      final weatherJson = json.decode(res.body);
      return weatherJson['name'];
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  Future<Weather> getWeatherData(String cityName) async {
    try {
      final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw errorMessageUnableToFetchData;
      }
      final weatherJson = json.decode(res.body);
      return Weather.fromJson(weatherJson);
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }

  Future<List<Weather>> getForecast(String cityName) async {
    try {
      final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$openWeatherApiKey';
      final res = await httpClient.get(url);
      if (res.statusCode != 200) {
        throw errorMessageUnableToFetchData;
      }
      final forecastJson = json.decode(res.body);
      List<Weather> weathers = Weather.fromForecastJson(forecastJson);
      return weathers;
    } catch (e) {
      throw errorMessageSomethingWentWrong;
    }
  }
}
