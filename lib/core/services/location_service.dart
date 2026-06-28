import 'package:geolocator/geolocator.dart';

import '../../models/location_model.dart';
import 'weather_service.dart';

class LocationService {
  final WeatherService _weatherService = WeatherService();

  Future<LocationModel> getCurrentLocation() async {
    final enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      throw Exception("GPS desligado.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception("Permissão negada.");
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permissão negada permanentemente.");
    }

    final position = await Geolocator.getCurrentPosition();

    return await _weatherService.reverseGeocoding(position.latitude, position.longitude);
  }
}
