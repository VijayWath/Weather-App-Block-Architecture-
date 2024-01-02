import 'dart:convert';

import 'package:weather_app/Models/weather_Model.dart';
import 'package:weather_app/data/DataProvider/weather_data_Provider.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);
  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Nagpur';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
