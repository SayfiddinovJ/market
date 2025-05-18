import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/extensions/extensions.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.category,
    required this.onTap,
    required this.image,
  });

  final String category;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: Colors.blue.shade300,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  image,
                  height: 60.w,
                  width: 60.w,
                  fit: BoxFit.fill,
                ),
              ),
              15.pw,
              Expanded(
                child: Text(
                  category,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
