import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes")),

      body: const Center(child: Text("Detalhes do clima")),
    );
  }
}
