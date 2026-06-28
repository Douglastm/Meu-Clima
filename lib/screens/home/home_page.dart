import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/location_provider.dart';
import '../../providers/weather_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String formatCountry(String code) {
    switch (code.toUpperCase()) {
      case "BR":
        return "Brasil";
      case "US":
        return "Estados Unidos";
      case "AR":
        return "Argentina";
      case "PY":
        return "Paraguai";
      case "UY":
        return "Uruguai";
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final locationProvider = context.watch<LocationProvider>();

    final weather = weatherProvider.weather;
    final location = locationProvider.location;

    if (weatherProvider.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (weatherProvider.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Clima")),
        body: Center(child: Text(weatherProvider.error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clima"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: "Pesquisar",
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.search);
            },
          ),
        ],
      ),
      body: weather == null
          ? const Center(child: Text("Nenhum dado encontrado."))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location?.city.isNotEmpty == true ? location!.city : weather.city, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  Text("${weather.temperature.toStringAsFixed(1)}°C", style: const TextStyle(fontSize: 72, fontWeight: FontWeight.w300)),

                  Text(weather.description.toUpperCase(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),

                  const SizedBox(height: 30),

                  Card(
                    elevation: 2,
                    child: ListTile(leading: const Icon(Icons.water_drop), title: const Text("Umidade"), trailing: Text("${weather.humidity}%")),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    elevation: 2,
                    child: ListTile(leading: const Icon(Icons.air), title: const Text("Velocidade do vento"), trailing: Text("${weather.wind.toStringAsFixed(2)} m/s")),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text("País"),
                      trailing: Text(location == null || location.country.isEmpty ? "-" : formatCountry(location.country)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    elevation: 2,
                    child: ListTile(leading: const Icon(Icons.map), title: const Text("Estado"), trailing: Text(location == null || location.state.isEmpty ? "-" : location.state)),
                  ),
                ],
              ),
            ),
    );
  }
}
