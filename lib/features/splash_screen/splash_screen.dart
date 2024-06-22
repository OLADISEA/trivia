import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/features/splash_screen/widgets/quiz_logo.dart';

import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OnboardingPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/quiz-logo3.png"),
                  // QuizLogo(text: "Q", text1: 'U',),
                  // SizedBox(height: 5,),
                  // QuizLogo(text: "I", text1: "Z")
                ],
              ),
            ),
          ),
        );
      }
    }







//
// return Scaffold(
// backgroundColor: Color(0XFFA76AE4),
// body: Stack(
// children: [
// Positioned(
// top: 20.h,
// left: 27.w,
// child: Container(
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.red.shade300
// ),
// height: 70.h,
// width: 200.w,
// //color: Colors.grey[300],
// child: Container(
// padding: EdgeInsets.all(30.w),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.grey.shade600,
//
// ),
// width: 50,
// height: 50,
//
// ),
// ),
// ),
//
// // Semi-circle container at the center right edge
// Align(
// alignment: Alignment.centerRight,
// child: ClipPath(
// clipper: SemiCircleClipper(),
// child: Container(
// width: 100,
// height: 100,
// color: Color(0XFFC7A8FC), // Change this color as needed
// ),
// ),
// ),
// ],
// ),
// );
// }
// }
//
// class SemiCircleClipper extends CustomClipper<Path> {
// @override
// Path getClip(Size size) {
// Path path = Path();
// path.moveTo(0, 0);
// path.lineTo(size.width / 2, 0);
// path.arcToPoint(
// Offset(size.width / 2, size.height),
// radius: Radius.circular(size.width / 2),
// clockwise: false,
// );
// path.lineTo(0, size.height);
// path.close();
// return path;
// }
//
// @override
// bool shouldReclip(CustomClipper<Path> oldClipper) {
// return false;
// }
// }

