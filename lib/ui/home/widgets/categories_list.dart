import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/bloc/product_bloc.dart';
import 'package:market/bloc/product_event.dart';
import 'package:market/data/models/category/categories.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/ui/widgets/zoom_tap_animation.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: Row(
        children: List.generate(categories.length, (index) {
          return Column(
            children: [
              ZoomTapAnimation(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.category,
                    arguments: categories[index],
                  );
                  context.read<ProductBloc>().add(
                    GetProductByCategoryEvent(
                      category: categories[index],
                      limit: 10,
                      page: 1,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.r),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      categoriesImage[index],
                      height: 70.w,
                      width: 70.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
