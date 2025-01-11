import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/widgets/submit_button.dart';
import 'package:trivia/core/home/widgets/home_header.dart';

// Assume AppColor.gradientColor1 and AppColor.gradientColor2 are defined elsewhere
import '../../../config/app_colors.dart';
import '../../../widgets/reusable_text.dart';
import '../widgets/quiz_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.gradientColor1, AppColor.gradientColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(80 * pi / 180), // 80 degrees in radians
          ),
        ),
        //padding: EdgeInsets.only(top: 35.h, left: 27.w, right: 27.w),
        child: Stack(
          clipBehavior: Clip.none, // Allows the Positioned widgets to be partially outside the Stack
          children: [
            HomeHeader(),
            // Red Container
            Positioned(
              top: 200.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: 100.h),
                width: 390.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Reusable(text: "Let's Play !",fontSize: 22.sp,fontWeight: FontWeight.w700,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Reusable(text: "Select a quiz of your choice",fontSize: 18.sp,fontWeight: FontWeight.w400,),
                    ),
                    const QuizCategory(),
                  ],
                ),
              ),
            ),
            // White Container overlapping the Red Container
            Positioned(
              top: 120.h, // Adjust this to control the overlap
              left: 50.w,
              right: 50.w,
              child: Container(
                padding: EdgeInsets.only(left: 15.w,top: 15.w),
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Reusable(text: 'Good Morning',fontSize: 18.sp,fontWeight: FontWeight.w800,),
                        SizedBox(height: 3.h,),

                        Container(
                          width: 130.w,
                          child: Reusable(text: 'Welcome to trivia quiz test platform',fontSize: 15.sp,),
                        ),
                        SizedBox(height: 15.h,),
                        SubmitButton(text: 'Learn More',
                          color: AppColor.gradientColor2,width: 100.w,height: 30.h,radius: 0,textColor: Colors.white,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 78.h,left: 27.w,right: 27.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HomeHeader(),
//                 SizedBox(height: 15.h,),
//                 const UserRanking(),
//                 SizedBox(height: 20.h,),
//                 //const QuizType(),
//                 SizedBox(height: 10.h,),
//                 Reusable(text: "Let's Play",fontSize: 25.sp,fontWeight: FontWeight.w700,),
//                 //SizedBox(height: 5.h,),
//
//               ],
//             ),
//           ),
//           const QuizCategory()
//
//         ],
//       ),
//     );
//   }
// }
