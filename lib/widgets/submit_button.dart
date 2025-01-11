import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'reusable_text.dart';


class SubmitButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final void Function()? onTap;
  const SubmitButton({super.key,
    this.onTap, required this.text, required this.color, this.textColor, this.width, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width??325.w,
        height: height??50.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius??15.r)
        ),
        child: Center(child: Reusable(text: text,fontSize: 18.sp,textColor: textColor,)),
      ),

    );
  }
}
