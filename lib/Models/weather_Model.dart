import 'dart:convert';

class WeatherModel {
  final double currentTemperature;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  WeatherModel({
    required this.currentTemperature,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
  });

  WeatherModel copyWith({
    double? currentTemperature,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
  }) {
    return WeatherModel(
      currentTemperature: currentTemperature ?? this.currentTemperature,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemperature': currentTemperature,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
    };
  }

  // final currentWeatherData = data['list'][0];

  //       final currentTemp = currentWeatherData['main']['temp'];
  //       final currentSky = currentWeatherData['weather'][0]['main'];
  //       final currentPressure = currentWeatherData['main']['pressure'];
  //       final currentWindSpeed = currentWeatherData['wind']['speed'];
  //       final currentHumidity = currentWeatherData['main']['humidity'];

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    String pressureValue = currentWeatherData['main']['pressure'].toString();
    String humidityvalue = currentWeatherData['main']['humidity'].toString();
    return WeatherModel(
      currentTemperature: currentWeatherData['main']['temp'] as double,
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: double.parse(pressureValue),
      currentWindSpeed: currentWeatherData['wind']['speed'] as double,
      currentHumidity: double.parse(humidityvalue),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemperature: $currentTemperature, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemperature == currentTemperature &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity;
  }

  @override
  int get hashCode {
    return currentTemperature.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode;
  }
}
