import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/category/categories.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/tabs/category/widget/category_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriyalar'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.sp,
          overflow: TextOverflow.ellipsis,
        ),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        children: [
          ...List.generate(categories.length, (index) {
            return CategoryRow(
              category: categories[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.category,
                  arguments: categories[index],
                );
              },
              image: categoriesImage[index],
            );
          }),
        ],
      ),
    );
  }
}
