import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../repositories/location_repository.dart';

class LocationProvider extends ChangeNotifier {
  final LocationRepository _repository = LocationRepository();

  LocationModel? _location;

  bool _loading = false;

  String? _error;

  LocationModel? get location => _location;

  bool get loading => _loading;

  String? get error => _error;

  Future<void> loadCurrentLocation() async {
    try {
      _loading = true;
      _error = null;

      notifyListeners();

      _location = await _repository.getCurrentLocation();
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;

    notifyListeners();
  }

  void setLocation(LocationModel location) {
    _location = location;
    notifyListeners();
  }
}
