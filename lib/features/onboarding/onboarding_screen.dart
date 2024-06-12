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
            SizedBox(height: 30,),
            Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 60,
                child: Reusable(text: "Challenge your knowledge and take quiz of your interest",fontSize: 22.sp,)),
            SizedBox(height: 100,),
            Image.asset("assets/images/quiz_logo.jpg",width: 260,),
            SizedBox(height: 70,),
            GetStarted()
          ],
        ),
      ),
    );
  }
}
