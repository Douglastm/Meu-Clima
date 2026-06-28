import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';
import '../../providers/weather_provider.dart';
import '../../core/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }

  Future<void> _load() async {
    print("1 - Iniciando Splash");

    try {
      final locationProvider = context.read<LocationProvider>();

      print("2 - Buscando localização");

      await locationProvider.loadCurrentLocation();

      print("3 - Localização carregada");

      final location = locationProvider.location;

      print(location);

      if (location == null) {
        print("Location veio nula");
        return;
      }

      final weatherProvider = context.read<WeatherProvider>();

      print("4 - Buscando clima");

      await weatherProvider.loadWeather(location.latitude, location.longitude);
      print("SPLASH");
      print(weatherProvider.hashCode);
      print(weatherProvider.weather);

      print("5 - Clima carregado");

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e, s) {
      print("ERRO:");
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.cloud, size: 90, color: Colors.blue),

            SizedBox(height: 20),

            Text("Weather App", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 40),

            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
