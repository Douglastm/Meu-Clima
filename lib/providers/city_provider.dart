import 'package:flutter/material.dart';

import '../models/city_model.dart';
import '../repositories/city_repository.dart';

class CityProvider extends ChangeNotifier {
  final CityRepository _repository = CityRepository();

  List<CityModel> _cities = [];

  bool _loading = false;

  String? _error;

  List<CityModel> get cities => _cities;

  bool get loading => _loading;

  String? get error => _error;

  Future<void> search(String city) async {
    try {
      _loading = true;

      notifyListeners();

      _cities = await _repository.searchCity(city);
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;

    notifyListeners();
  }

  void clear() {
    _cities.clear();

    notifyListeners();
  }
}
