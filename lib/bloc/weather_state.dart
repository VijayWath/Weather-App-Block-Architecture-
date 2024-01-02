part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSucess extends WeatherState {
  final WeatherModel currentWeather;
  final List<ForcastModel> forecast;

  WeatherSucess(this.currentWeather, this.forecast);
}

final class WeatherFailuar extends WeatherState {
  final String error;
  WeatherFailuar(this.error);
}

final class WeatherLoading extends WeatherState {}
