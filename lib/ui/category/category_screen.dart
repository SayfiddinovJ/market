import 'package:flutter/material.dart';
import 'package:market/data/models/category/categories.dart';
import 'package:market/data/models/product/product_model.dart';
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
                return ProductCard(
                  product: ProductModel(
                    productId: '',
                    name: '',
                    type: '',
                    price: '',
                    image: '',
                    status: '',
                    category: '',
                    description: '',
                    createdAt: '',
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.product,
                      arguments: ProductModel(
                        productId: index.toString(),
                        name: 'Name ${categories[index]}',
                        type: 'Type ${categories[index]}',
                        price: 'Price $index',
                        image: categoriesImage[index],
                        status: index.isEven ? "Bor" : "Yo'q",
                        category: categories[index],
                        description: 'This is description',
                        createdAt: 'createdAt',
                      ),
                    );
                  },
                );
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
