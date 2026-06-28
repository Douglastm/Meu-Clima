import 'package:dio/dio.dart';

import '../../models/city_model.dart';
import '../constants/api_constants.dart';

class CityService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.weatherBaseUrl, connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

  Future<List<CityModel>> searchCity(String city) async {
    try {
      print("======== BUSCANDO CIDADE ========");
      print(city);

      final response = await _dio.get("/geo/1.0/direct", queryParameters: {"q": city, "limit": 10, "appid": ApiConstants.weatherApiKey});

      print("STATUS:");
      print(response.statusCode);

      print("BODY:");
      print(response.data);

      final List list = response.data;

      return list.map((e) => CityModel.fromJson(e)).toList();
    } on DioException catch (e) {
      print("ERRO DIO");
      print(e.response?.statusCode);
      print(e.response?.data);

      rethrow;
    }
  }
}
