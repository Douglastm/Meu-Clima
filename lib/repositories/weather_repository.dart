import 'package:flutter/foundation.dart';

import '../core/database/database_helper.dart';
import '../core/services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherService _service = WeatherService();

  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    final weather = await _service.getWeather(latitude, longitude);

    // SQLite não funciona na Web
    if (!kIsWeb) {
      await DatabaseHelper.instance.insertWeather(weather);
    }

    return weather;
  }

  Future<List<WeatherModel>> getHistory() async {
    if (kIsWeb) {
      return [];
    }

    return DatabaseHelper.instance.getWeatherHistory();
  }

  Future<void> clearHistory() async {
    if (!kIsWeb) {
      await DatabaseHelper.instance.clearWeather();
    }
  }
}
