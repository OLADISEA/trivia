import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Reusable(text: "Hi, Oladisea",fontSize: 25.sp,fontWeight: FontWeight.w600,),
            Reusable(text: "Let's make this day productive",fontSize: 18.sp,)
          ],
        ),
        CircleAvatar(
          radius: 22.r,
            child: Image.asset("assets/images/user-image.png"))
      ],
    );
  }
}
