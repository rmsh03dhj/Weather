import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String cityName;
  final double longitude;
  final double latitude;

  FetchWeather({this.cityName, this.longitude, this.latitude});

  @override
  String toString() => 'FetchWeather';
}
