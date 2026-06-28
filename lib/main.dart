import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/city_provider.dart';
import 'providers/location_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/country_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => CityProvider()),
        ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: const WeatherApp(),
    ),
  );
}
