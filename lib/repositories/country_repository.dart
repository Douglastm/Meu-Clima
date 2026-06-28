import '../core/services/country_service.dart';

class CountryRepository {
  final CountryService service = CountryService();

  Future<List<String>> getCountries() {
    return service.getCountries();
  }

  Future<List<String>> getStates(String country) {
    return service.getStates(country);
  }

  Future<List<String>> getCities(String country, String state) {
    return service.getCities(country, state);
  }
}
