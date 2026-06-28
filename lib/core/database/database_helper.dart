import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/location_model.dart';
import '../../models/weather_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "weather.db");

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE locations(
id INTEGER PRIMARY KEY AUTOINCREMENT,
country TEXT,
state TEXT,
city TEXT,
latitude REAL,
longitude REAL,
isCurrent INTEGER
)
''');

    await db.execute('''
CREATE TABLE weather(
id INTEGER PRIMARY KEY AUTOINCREMENT,
city TEXT,
temperature REAL,
description TEXT,
humidity INTEGER,
wind REAL,
icon TEXT,
date TEXT
)
''');

    await db.execute('''
CREATE TABLE favorites(
id INTEGER PRIMARY KEY AUTOINCREMENT,
city TEXT,
country TEXT
)
''');
  }

  //-------------------------
  // LOCATION
  //-------------------------

  Future<int> insertLocation(LocationModel location) async {
    final db = await database;
    return db.insert("locations", location.toMap());
  }

  Future<List<LocationModel>> getLocations() async {
    final db = await database;

    final result = await db.query("locations");

    return result.map(LocationModel.fromMap).toList();
  }

  Future<void> deleteLocations() async {
    final db = await database;

    await db.delete("locations");
  }

  //-------------------------
  // WEATHER
  //-------------------------

  Future<int> insertWeather(WeatherModel weather) async {
    final db = await database;

    return db.insert("weather", weather.toMap());
  }

  Future<List<WeatherModel>> getWeatherHistory() async {
    final db = await database;

    final result = await db.query("weather", orderBy: "date DESC");

    return result.map(WeatherModel.fromMap).toList();
  }

  Future<void> clearWeather() async {
    final db = await database;

    await db.delete("weather");
  }

  //-------------------------
  // FAVORITES
  //-------------------------

  Future<void> addFavorite(String city, String country) async {
    final db = await database;

    await db.insert("favorites", {"city": city, "country": country});
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;

    return db.query("favorites");
  }

  Future<void> removeFavorite(String city) async {
    final db = await database;

    await db.delete("favorites", where: "city=?", whereArgs: [city]);
  }
}
