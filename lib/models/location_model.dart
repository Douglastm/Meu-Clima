class LocationModel {
  final int? id;
  final String country;
  final String state;
  final String city;
  final double latitude;
  final double longitude;
  final bool isCurrent;

  LocationModel({this.id, required this.country, required this.state, required this.city, required this.latitude, required this.longitude, this.isCurrent = false});

  Map<String, dynamic> toMap() {
    return {"id": id, "country": country, "state": state, "city": city, "latitude": latitude, "longitude": longitude, "isCurrent": isCurrent ? 1 : 0};
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(id: map["id"], country: map["country"], state: map["state"], city: map["city"], latitude: map["latitude"], longitude: map["longitude"], isCurrent: map["isCurrent"] == 1);
  }
}
