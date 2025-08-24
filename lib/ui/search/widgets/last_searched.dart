import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/storage/storage_repository.dart';
import 'package:market/ui/widgets/zoom_tap_animation.dart';
import 'package:market/utils/extensions/extensions.dart';

class LastSearched extends StatelessWidget {
  const LastSearched({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    List<String> searchedProducts = StorageRepository.getList(
      'searchedProducts',
    );
    return searchedProducts.isEmpty
        ? const Center(child: Text('Oxirgi qidiruvlar bo\'sh'))
        : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kToolbarHeight + 20.w,
            vertical: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oxirgi qidiruvlar:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
              ),
              Wrap(
                children: [
                  ...List.generate(
                    searchedProducts.length,
                    (index) => ZoomTapAnimation(
                      onTap: () => onChanged(searchedProducts[index]),
                      child: Container(
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
                          searchedProducts[index],
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
