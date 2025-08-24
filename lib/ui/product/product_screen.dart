import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/models/product/product_model.dart';
import 'package:market/utils/extensions/extensions.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final ProductModel product;

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

          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            // IconButton(onPressed: () {}, icon: Icon(Icons.upload_outlined)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight),
              Hero(
                tag: product.productId,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(product.category),
                    ),
                    10.ph,
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp,
                      ),
                    ),
                    10.ph,
                    Text(
                      '${product.price}so\'m/${product.type.toLowerCase()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                      ),
                    ),
                    10.ph,
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color:
                                product.status == 'Bor'
                                    ? Colors.green
                                    : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          product.status,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                            color:
                                product.status == 'Bor'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    const Divider(color: Colors.grey),
                    10.ph,
                    Text(
                      'Mahsulot haqida',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                    10.ph,
                    Text(product.description),
                    20.ph,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
