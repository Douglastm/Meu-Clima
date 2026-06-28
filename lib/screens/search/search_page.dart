import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/location_model.dart';
import '../../providers/city_provider.dart';
import '../../providers/country_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/weather_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CountryProvider>().loadCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = context.watch<CountryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisar Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "País", border: OutlineInputBorder()),
              value: selectedCountry,
              items: countryProvider.countries.map((country) => DropdownMenuItem(value: country, child: Text(country))).toList(),
              onChanged: (value) async {
                setState(() {
                  selectedCountry = value;
                  selectedState = null;
                  selectedCity = null;
                });

                if (value != null) {
                  await context.read<CountryProvider>().loadStates(value);
                }
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Estado", border: OutlineInputBorder()),
              value: selectedState,
              items: countryProvider.states.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(),
              onChanged: (value) async {
                setState(() {
                  selectedState = value;
                  selectedCity = null;
                });

                if (selectedCountry != null && value != null) {
                  await context.read<CountryProvider>().loadCities(selectedCountry!, value);
                }
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Cidade", border: OutlineInputBorder()),
              value: selectedCity,
              items: countryProvider.cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton(
                onPressed: selectedCity == null
                    ? null
                    : () async {
                        try {
                          final cityProvider = context.read<CityProvider>();

                          final weatherProvider = context.read<WeatherProvider>();

                          final locationProvider = context.read<LocationProvider>();

                          await cityProvider.search("$selectedCity,$selectedState,$selectedCountry");

                          if (cityProvider.cities.isEmpty) {
                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cidade não encontrada.")));
                            return;
                          }

                          final city = cityProvider.cities.first;

                          // Atualiza a localização
                          locationProvider.setLocation(LocationModel(country: city.country, state: city.state, city: city.city, latitude: city.latitude, longitude: city.longitude, isCurrent: false));

                          // Atualiza o clima
                          await weatherProvider.loadWeather(city.latitude, city.longitude);

                          if (!mounted) return;

                          Navigator.pop(context);
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                child: const Text("Buscar Clima"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
