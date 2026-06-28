import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherModel? _weather;

  bool _loading = false;

  String? _error;

  List<WeatherModel> _history = [];

  WeatherModel? get weather => _weather;

  bool get loading => _loading;

  String? get error => _error;

  List<WeatherModel> get history => _history;

  Future<void> loadWeather(double latitude, double longitude) async {
    try {
      _loading = true;
      _error = null;

      notifyListeners();

      _weather = await _repository.getWeather(latitude, longitude);

      print("====== WEATHER ======");
      print(_weather);

      _history = await _repository.getHistory();

      print("====== HISTORY ======");
      print(_history.length);
    } catch (e, s) {
      print("ERRO WEATHER");

      print(e);

      print(s);

      _error = e.toString();
    }

    _loading = false;

    notifyListeners();
  }

  Future<void> loadHistory() async {
    _history = await _repository.getHistory();

    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _repository.clearHistory();

    _history.clear();

    notifyListeners();
  }
}
