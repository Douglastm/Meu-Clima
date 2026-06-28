import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class CountryService {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.countriesBaseUrl));

  Future<List<String>> getCountries() async {
    final response = await dio.get("/countries");

    final List list = response.data["data"];

    return list.map<String>((e) => e["country"]).toList();
  }

  Future<List<String>> getStates(String country) async {
    final response = await dio.post("/countries/states", data: {"country": country});

    final List list = response.data["data"]["states"];

    return list.map<String>((e) => e["name"]).toList();
  }

  Future<List<String>> getCities(String country, String state) async {
    final response = await dio.post("/countries/state/cities", data: {"country": country, "state": state});

    final List list = response.data["data"];

    return list.cast<String>();
  }
}
