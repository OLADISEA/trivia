import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/config/app_colors.dart';
import 'package:trivia/widgets/reusable_text.dart';

import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Color blueColor = const Color(0xFF2E98E9);
  final Color purpleColor = const Color(0xFF7F39FB);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnboardingPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.gradientColor1, AppColor.gradientColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(80 * pi / 180), // 80 degrees in radians
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300.h,),
            Container(
              height: 200.h,
              width: 200.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: SizedBox(
                  width: 80.h,
                  child: Transform.rotate(
                    angle: -30 * pi / 180, // Rotate the text by 80 degrees
                    child: Reusable(
                      textAlign: TextAlign.center,
                      text: "Trivia Quiz",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 280.h,),
            Reusable(text: "test platform for trivia enthusiasts",textColor: Colors.white,fontSize: 12.sp,)
          ],
        ),
      ),
    );
  }
}
