import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/extensions/extensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsetsGeometry.symmetric(vertical: 5.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                hintText: 'Mahsulotlarni qidirish...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Text(
                  'Oxirgi qidiruvlar:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Wrap(
                  children: [
                    ...List.generate(
                      10,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(
                                context,
                              ).extension<ContainerColors>()!.background,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'index $index',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
