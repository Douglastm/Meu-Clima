import 'package:flutter/material.dart';

import '../repositories/country_repository.dart';

class CountryProvider extends ChangeNotifier {
  final CountryRepository repository = CountryRepository();

  List<String> countries = [];

  List<String> states = [];

  List<String> cities = [];

  bool loading = false;

  Future<void> loadCountries() async {
    loading = true;

    notifyListeners();

    countries = await repository.getCountries();

    loading = false;

    notifyListeners();
  }

  Future<void> loadStates(String country) async {
    loading = true;

    notifyListeners();

    states = await repository.getStates(country);

    loading = false;

    notifyListeners();
  }

  Future<void> loadCities(String country, String state) async {
    loading = true;

    notifyListeners();

    cities = await repository.getCities(country, state);

    loading = false;

    notifyListeners();
  }
}
