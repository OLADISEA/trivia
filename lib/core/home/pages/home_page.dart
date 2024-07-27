import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';
import '../widgets/home_header.dart';
import '../widgets/quiz_category.dart';
import '../widgets/user_ranking.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 78.h,left: 27.w,right: 27.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(),
                SizedBox(height: 15.h,),
                const UserRanking(),
                SizedBox(height: 20.h,),
                //const QuizType(),
                SizedBox(height: 10.h,),
                Reusable(text: "Let's Play",fontSize: 25.sp,fontWeight: FontWeight.w700,),
                //SizedBox(height: 5.h,),

              ],
            ),
          ),
          const QuizCategory()

        ],
      ),
    );
  }
}
