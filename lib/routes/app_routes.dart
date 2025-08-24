import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/data/models/product/product_model.dart';
import 'package:market/ui/category/category_screen.dart';
import 'package:market/ui/category_search/category_search_screen.dart';
import 'package:market/ui/home/home_screen.dart';
import 'package:market/ui/product/product_screen.dart';
import 'package:market/ui/products/all_products_screen.dart';
import 'package:market/ui/search/search_screen.dart';
import 'package:market/ui/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String home = "/home";
  static const String search = "/search";
  static const String searchByCategory = "/search_by_category";
  static const String category = "/category";
  static const String product = "/product";
  static const String products = "/products";
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
      case RouteNames.searchByCategory:
        return CupertinoPageRoute(
          builder:
              (context) =>
                  CategorySearchScreen(category: settings.arguments.toString()),
        );
      case RouteNames.category:
        return CupertinoPageRoute(
          builder:
              (context) => CategoryScreen(name: settings.arguments.toString()),
        );
      case RouteNames.product:
        return CupertinoPageRoute(
          builder:
              (context) =>
                  ProductScreen(product: settings.arguments as ProductModel),
        );
      case RouteNames.products:
        return CupertinoPageRoute(builder: (context) => AllProductsScreen());
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
