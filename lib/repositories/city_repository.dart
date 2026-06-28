import '../core/services/city_service.dart';
import '../models/city_model.dart';

class CityRepository {
  final CityService _service = CityService();

  Future<List<CityModel>> searchCity(String city) async {
    return await _service.searchCity(city);
  }
}
