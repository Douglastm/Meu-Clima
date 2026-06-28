class WeatherModel {
  final int? id;
  final String city;
  final double temperature;
  final String description;
  final int humidity;
  final double wind;
  final String icon;
  final DateTime date;

  WeatherModel({this.id, required this.city, required this.temperature, required this.description, required this.humidity, required this.wind, required this.icon, required this.date});

  Map<String, dynamic> toMap() {
    return {"id": id, "city": city, "temperature": temperature, "description": description, "humidity": humidity, "wind": wind, "icon": icon, "date": date.toIso8601String()};
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: map["id"],
      city: map["city"],
      temperature: map["temperature"],
      description: map["description"],
      humidity: map["humidity"],
      wind: map["wind"],
      icon: map["icon"],
      date: DateTime.parse(map["date"]),
    );
  }
}
