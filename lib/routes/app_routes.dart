import 'package:flutter/material.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/ui/splash/splash_screen.dart';
import 'package:market/ui/tabs/category/category_screen.dart';
import 'package:market/ui/tabs/category/subs/category_product_screen.dart';
import 'package:market/ui/tabs/home/home_screen.dart';
import 'package:market/ui/tabs/product/product_detail_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String homeScreen = "/home";
  static const String categoryScreen = "/category";
  static const String categoryProductScreen = "/categoryProduct";
  static const String productDetailScreen = "/productDetail";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.categoryScreen:
        return MaterialPageRoute(builder: (context) => const CategoryScreen());
      case RouteNames.categoryProductScreen:
        return MaterialPageRoute(
          builder:
              (context) =>
                  CategoryProductScreen(category: settings.arguments as String),
        );
      case RouteNames.productDetailScreen:
        return MaterialPageRoute(
          builder:
              (context) => ProductDetailScreen(
                product: settings.arguments as ProductModel,
              ),
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text("Route not found!"))),
        );
    }
  }
}
