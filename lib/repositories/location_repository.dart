import '../core/database/database_helper.dart';
import '../core/services/location_service.dart';
import '../models/location_model.dart';
import 'package:flutter/foundation.dart';

class LocationRepository {
  final LocationService _service = LocationService();

  Future<LocationModel> getCurrentLocation() async {
    final location = await _service.getCurrentLocation();

    if (!kIsWeb) {
      await DatabaseHelper.instance.deleteLocations();
      await DatabaseHelper.instance.insertLocation(location);
    }

    return location;
  }

  Future<List<LocationModel>> getSavedLocations() async {
    return DatabaseHelper.instance.getLocations();
  }
}
