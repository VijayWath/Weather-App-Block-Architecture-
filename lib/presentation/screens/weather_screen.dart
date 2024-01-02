import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/additional_info_item.dart';
import 'package:weather_app/presentation/widgets/hourly_forecast_item.dart';
import 'package:weather_app/presentation/widgets/main_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(WeatherRelode());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailuar) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is! WeatherSucess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.currentWeather;
          final forecast = state.forecast;

          final currentTemp = ((data.currentTemperature) - 273.15);
          final currentSky = data.currentSky;
          final currentPressure = data.currentPressure;
          final currentWindSpeed = data.currentWindSpeed;
          final currentHumidity = data.currentHumidity;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                MainCard(
                    currentTemp: currentTemp.toStringAsFixed(2),
                    currentSky: currentSky),
                const SizedBox(height: 20),
                const Text(
                  'weather forcast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                // forcast scroll view
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecast.length,
                      itemBuilder: (ctx, i) {
                        final hourlyForcast = forecast[i].hourlyTemp;
                        final time = forecast[i].time;

                        return HourlyForecastItem(
                          temperature: hourlyForcast.toString(),
                          time: DateFormat.j().format(time),
                          icon: forecast[i].hourlysky == 'Clouds' ||
                                  forecast[i].hourlysky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      }),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
