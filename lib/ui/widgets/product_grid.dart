import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/utils/extensions/extensions.dart';

class ProductGridTile extends StatelessWidget {
  final ProductModel product;

  const ProductGridTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.productDetailScreen,
            arguments: product,
          );
        },
        child: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Text(
                    product.name,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textScaler: TextScaler.noScaling,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    "${product.price}so'm",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textScaler: TextScaler.noScaling,
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Text(
                        'Holati: ',
                        textScaler: TextScaler.noScaling,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Container(
                        // width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              product.status == 'Bor'
                                  ? Colors.green
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            product.status == 'Bor' ? 'Bor ✅' : 'Yo\'q❌',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaler: TextScaler.noScaling,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                5.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
