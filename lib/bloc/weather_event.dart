part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherRelode extends WeatherEvent {}

final class WeatherFetched extends WeatherEvent {}
