import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Models/forcast_Model.dart';
import 'package:weather_app/data/DataProvider/geo_location.dart';
import 'package:weather_app/data/DataProvider/weather_data_Provider.dart';

class ForecastRepository {
  final WeatherDataProvider _weatherDataProvider;

  ForecastRepository({required WeatherDataProvider weatherDataProvider})
      : _weatherDataProvider = weatherDataProvider;
  Future<List<ForcastModel>> getForecastWeather() async {
    final cityName = await CurrentGeoLocation().determinePosition();
    try {
      final weatherData =
          await _weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);
      List<ForcastModel> forecastList = [];
      for (int i = 0; i < 5; i++) {
        final hourlyForcast = data['list'][i + 2];
        final timeDT = hourlyForcast['dt_txt'].toString();
        final time = DateTime.parse(timeDT);
        final hourlyTemp = hourlyForcast['main']['temp'];
        final hourlysky = hourlyForcast['weather'][0]['main'];

        forecastList.add(ForcastModel(
            hourlyTemp: hourlyTemp, hourlysky: hourlysky, time: time));
      }

      return forecastList;
    } catch (e) {
      throw e.toString();
    }
  }
}
