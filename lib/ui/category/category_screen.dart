import 'package:flutter/material.dart';
import 'package:market/data/models/category/categories.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/widgets/product_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight)),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductCard(index: index);
              }, childCount: categoriesImage.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Qatorlar soni
                mainAxisSpacing: 12, // Vertikal bo'shliq
                crossAxisSpacing: 0, // Gorizontal bo'shliq
                childAspectRatio: 0.7, // Elementlar proporsiyasi
              ),
            ),
          ],
        ),
      ),
    );
  }
}
