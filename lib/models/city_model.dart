class CityModel {
  final String country;
  final String state;
  final String city;
  final double latitude;
  final double longitude;

  CityModel({required this.country, required this.state, required this.city, required this.latitude, required this.longitude});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(country: json["country"] ?? "", state: json["state"] ?? "", city: json["name"] ?? "", latitude: (json["lat"] as num).toDouble(), longitude: (json["lon"] as num).toDouble());
  }
}
