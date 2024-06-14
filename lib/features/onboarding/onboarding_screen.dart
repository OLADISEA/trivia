import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/onboarding/widgets/get_started.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30.w,top: 120.h,right: 30.w),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Reusable(text: "Welcome to Trivia Quiz",fontSize: 25.sp,),
            SizedBox(height: 35.h,),
            Container(
                padding: EdgeInsets.only(left: 15.w,right: 15.w),
                height: 60.h,
                child: Reusable(text: "Challenge your knowledge and take quiz of your interest",fontSize: 22.sp,)),
            SizedBox(height: 100.h,),
            Image.asset("assets/images/quiz_logo.jpg",width: 300.w,),
            SizedBox(height: 70.h,),
            GetStarted()
          ],
        ),
      ),
    );
  }
}
