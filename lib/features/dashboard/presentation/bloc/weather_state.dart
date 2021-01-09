import 'package:equatable/equatable.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError(this.errorMessage);
}
