import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/ui/home/home_screen.dart';
import 'package:market/ui/search/search_screen.dart';
import 'package:market/ui/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String home = "/home";
  static const String search = "/search";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.home:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.search:
        return CupertinoPageRoute(builder: (context) => const SearchScreen());
      default:
        return CupertinoPageRoute(
          builder:
              (context) => const Scaffold(
                body: Center(child: Text("Sahifa topilmadi!")),
              ),
        );
    }
  }
}
