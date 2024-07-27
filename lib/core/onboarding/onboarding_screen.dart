import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/onboarding/widgets/get_started.dart';

import '../../widgets/reusable_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30.w,top: 100.h,right: 30.w),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(child: Reusable(text: "Trivia Quiz",fontSize: 30.sp,textColor: Colors.black,fontWeight: FontWeight.w900,)),
            SizedBox(height: 35.h,),
            Container(
                padding: EdgeInsets.only(left: 15.w,right: 15.w),
                height: 60.h,
                child: Reusable(text: "Challenge your knowledge and take quiz of your interest",fontSize: 18.sp,textAlign: TextAlign.center,)),
            SizedBox(height: 100.h,),
            Image.asset("assets/images/quiz.png",width: 150.w,height: 150.h,),
            SizedBox(height: 280.h,),
            GetStarted()
          ],
        ),
      ),
    );
  }
}
