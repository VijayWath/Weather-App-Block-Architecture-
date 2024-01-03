import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/Models/forcast_Model.dart';
import 'package:weather_app/Models/weather_Model.dart';
import 'package:weather_app/data/repository/forecast_repsitory.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final ForecastRepository forecastRepository;
  WeatherBloc(this.weatherRepository, this.forecastRepository)
      : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
    on<WeatherRelode>(_getCurrentWeather);
  }
  void _getCurrentWeather(event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      final forecast = await forecastRepository.getForecastWeather();
      emit(WeatherSucess(weather, forecast));
    } catch (e) {
      emit(
        WeatherFailuar(
          e.toString(),
        ),
      );
    }
  }
}
