import 'package:flutter/material.dart';

import '../../screens/home/home_page.dart';
import '../../screens/search/search_page.dart';
import '../../screens/splash/splash_page.dart';
import '../../screens/details/weather_details_page.dart';

class AppRoutes {
  static const splash = "/";

  static const home = "/home";

  static const search = "/search";

  static const favorites = "/favorites";

  static const details = "/details";

  static Map<String, WidgetBuilder> routes = {splash: (_) => const SplashPage(), home: (_) => const HomePage(), search: (_) => const SearchPage(), details: (_) => const WeatherDetailsPage()};
}
