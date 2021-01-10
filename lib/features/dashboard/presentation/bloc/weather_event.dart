import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeatherForCurrentLocation extends WeatherEvent {
  FetchWeatherForCurrentLocation();

  @override
  String toString() => 'FetchWeatherForCurrentLocation';
}

class FetchWeatherForGivenLocation extends WeatherEvent {
  final Position position;

  FetchWeatherForGivenLocation({@required this.position});

  @override
  String toString() => 'FetchWeatherForGivenLocation';
}

class FetchWeatherForGivenCity extends WeatherEvent {
  final String cityName;

  FetchWeatherForGivenCity({@required this.cityName});

  @override
  String toString() => 'FetchWeatherForGivenCity';
}
