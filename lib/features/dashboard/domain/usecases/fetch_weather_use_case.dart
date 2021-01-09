import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:weather/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:weather/features/registration_or_login/domain/usecases/base_use_case.dart';
import 'package:weather/features/utils/constants/strings.dart';

abstract class FetchWeatherUseCase implements BaseUseCase<Weather, FetchWeatherParams> {}

class FetchWeatherUseCaseImpl implements FetchWeatherUseCase {
  final weatherRepository = sl<WeatherRepository>();
  @override
  Future<Either<Failure, Weather>> execute(FetchWeatherParams fetchWeatherParams) async {
    try {
      final weather = await weatherRepository.getWeather(fetchWeatherParams.cityName,
          latitude: fetchWeatherParams.latitude, longitude: fetchWeatherParams.longitude);
        return Right(weather);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class FetchWeatherParams {
  final String cityName;
  final double latitude;
  final double longitude;

  FetchWeatherParams(this.cityName, this.latitude, this.longitude);
}
