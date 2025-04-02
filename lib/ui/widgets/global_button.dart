import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/extensions/extensions.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon = '',
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16,
  });

  final VoidCallback? onPressed;
  final String text;
  final String icon;
  final Color color;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: icon.isNotEmpty,
                child: Image.asset(icon, height: 24.w, width: 24.w),
              ),
              5.pw,
              Text(
                text,
                style: TextStyle(fontSize: fontSize.sp, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
