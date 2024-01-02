import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc_observer.dart';
import 'package:weather_app/data/DataProvider/weather_data_Provider.dart';
import 'package:weather_app/data/repository/forecast_repsitory.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';

void main() {
  Bloc.observer = blocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // create: (context) => WeatherRepository(WeatherDataProvider()),
      providers: [
        RepositoryProvider(
            create: (context) => WeatherRepository(WeatherDataProvider())),
        RepositoryProvider(
            create: (context) =>
                ForecastRepository(weatherDataProvider: WeatherDataProvider()))
      ],
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepository>(),
            context.read<ForecastRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const WeatherScreen(),
        ),
      ),
    );
  }
}
