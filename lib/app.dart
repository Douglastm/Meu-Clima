import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),

      initialRoute: AppRoutes.splash,

      routes: AppRoutes.routes,
    );
  }
}
