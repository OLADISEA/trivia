import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';


class SubmitButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? width;
  final void Function()? onTap;
  const SubmitButton({super.key, this.onTap, required this.text, required this.color, this.textColor, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width??325.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r)
        ),
        child: Center(child: Reusable(text: text,fontSize: 18.sp,textColor: textColor,)),
      ),

    );
  }
}
