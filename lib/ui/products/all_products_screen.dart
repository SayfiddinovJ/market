import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/product_bloc.dart';
import 'package:market/bloc/product_state.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/widgets/product_card.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Barcha mahsulotlar'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return GridView.count(
              crossAxisCount: 2,
              children:
                  state.products
                      .map((e) => ProductCard(product: e, onTap: () {}))
                      .toList(),
            );
          },
        ),
      ),
    );
  }
}
