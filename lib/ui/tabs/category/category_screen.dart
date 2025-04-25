import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/category/categories.dart';
import 'package:market/ui/tabs/category/subs/category_product_screen.dart';
import 'package:market/ui/tabs/category/widget/category_row.dart';
import 'package:market/utils/extensions/extensions.dart';
import 'package:market/utils/navigation/navigation.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Kategoriyalar'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.sp,
          color: Colors.black,
          overflow: TextOverflow.ellipsis
        ),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ...List.generate(categories.length, (index) {
              return CategoryRow(
                category: categories[index],
                onTap: () {
                  context.push(
                    CategoryProductScreen(category: categories[index]),
                  );
                },
                image: categoriesImage[index],
              );
            }),
            24.ph,
          ],
        ),
      ),
    );
  }
}
