import 'package:flutter/material.dart';
import 'package:market/models/category/categories.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/tabs/category/widget/category_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriyalar'),
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
                  RouteNames.categoryProductScreen,
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

  @override
  bool get wantKeepAlive => true;
}
