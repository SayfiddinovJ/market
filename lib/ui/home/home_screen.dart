import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/models/category/categories.dart';
import 'package:market/data/models/product/product_model.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/home/widgets/categories_list.dart';
import 'package:market/ui/home/widgets/search_container.dart';
import 'package:market/ui/widgets/global_button.dart';
import 'package:market/ui/widgets/product_card.dart';
import 'package:market/ui/widgets/theme_changer.dart';
import 'package:market/utils/images/app_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(AppImages.appLogo),
          ),
          title: Text(
            'SSL Market',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
              icon: Icon(Icons.search),
            ),
            ThemeChanger(),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const SearchContainer()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
                child: Text(
                  'Kategoriyalar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const CategoriesList()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Text(
                  'Mahsulotlar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductCard(
                  index: index,
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
            SliverToBoxAdapter(child: GlobalButton()),
          ],
        ),
      ),
    );
  }
}
