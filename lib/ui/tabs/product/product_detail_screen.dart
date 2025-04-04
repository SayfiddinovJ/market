import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/models/product/product_model.dart';
import 'package:market/ui/widgets/global_button.dart';
import 'package:market/utils/extensions/extensions.dart';
import 'package:market/utils/navigation/navigation.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showImageViewer(
                      context,
                      CachedNetworkImageProvider(product.image),
                      useSafeArea: true,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                    );
                  },
                  child: Hero(
                    tag: product.productId,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 20.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.5),

                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, size: 25.sp),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.ph,
                  Text(
                    '${product.type}: ${product.price} so\'m',
                    style: TextStyle(fontSize: 20.sp, color: Colors.blue),
                  ),
                  15.ph,
                  Text(
                    "Tavsif: ${product.description}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  15.ph,
                  Text(
                    "Kategoriyasi: ${product.category}",
                    softWrap: true,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  15.ph,
                  Row(
                    children: [
                      Text(
                        'Mahsulot holati: ',
                        style: TextStyle(fontSize: 18.sp),
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
                            product.status == 'Bor' ? 'Bor ✅' : 'Mavjud emas❌',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  20.ph,
                  GlobalButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: 'Ortga qaytish',
                    textColor: Colors.white,
                    fontSize: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
