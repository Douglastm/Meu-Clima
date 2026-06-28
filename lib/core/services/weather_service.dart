import 'package:dio/dio.dart';

import '../../models/location_model.dart';
import '../../models/weather_model.dart';
import '../constants/api_constants.dart';

class WeatherService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.weatherBaseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    final response = await _dio.get("/data/2.5/weather", queryParameters: {"lat": latitude, "lon": longitude, "appid": ApiConstants.weatherApiKey, "units": "metric", "lang": "pt_br"});

    final data = response.data;

    return WeatherModel(
      city: data["name"],
      temperature: (data["main"]["temp"] as num).toDouble(),
      description: data["weather"][0]["description"],
      humidity: data["main"]["humidity"],
      wind: (data["wind"]["speed"] as num).toDouble(),
      icon: data["weather"][0]["icon"],
      date: DateTime.now(),
    );
  }

  Future<LocationModel> reverseGeocoding(double latitude, double longitude) async {
    final response = await _dio.get("/geo/1.0/reverse", queryParameters: {"lat": latitude, "lon": longitude, "limit": 1, "appid": ApiConstants.weatherApiKey});

    final List data = response.data;

    if (data.isEmpty) {
      throw Exception("Localização não encontrada.");
    }

    final item = data.first;

    return LocationModel(country: item["country"] ?? "", state: item["state"] ?? "", city: item["name"] ?? "", latitude: latitude, longitude: longitude, isCurrent: true);
  }
}
