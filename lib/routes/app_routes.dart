import 'package:flutter/material.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/ui/splash/splash_screen.dart';
import 'package:market/ui/tabs/category/subs/category_product_screen.dart';
import 'package:market/ui/tabs/product/product_detail_screen.dart';
import 'package:market/ui/tabs/tab_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String tabs = "/tabs";
  static const String category = "/categoryProduct";
  static const String productDetail = "/productDetail";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.tabs:
        return MaterialPageRoute(builder: (context) => const TabScreen());
      case RouteNames.category:
        return MaterialPageRoute(
          builder:
              (context) =>
                  CategoryProductScreen(category: settings.arguments as String),
        );
      case RouteNames.productDetail:
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
