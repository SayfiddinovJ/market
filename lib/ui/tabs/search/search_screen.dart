import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/repository/product_repo.dart';
import 'package:market/ui/shimmer/shimmer_grid_tile.dart';
import 'package:market/ui/widgets/product_grid.dart';

class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate() : super(searchFieldLabel: "Mahsulot qidirish...");

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search, color: Colors.black),
        onPressed: () {
          showResults(context);
        },
      ),
      IconButton(
        icon: Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: FutureBuilder<List<ProductModel>>(
          future: context.read<ProductRepo>().searchProduct(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) => const ShimmerGridTile(),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("Xatolik: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Mahsulot topilmadi!"));
            }

            return ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder:
                      (context, index) =>
                          ProductGridTile(product: snapshot.data![index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 100.h),
              Text(
                'Bugun qanday mahsulot qidirmoqchisiz?',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
