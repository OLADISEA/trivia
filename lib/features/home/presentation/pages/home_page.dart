import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/home/presentation/widgets/home_header.dart';
import 'package:trivia/features/home/presentation/widgets/quiz_category.dart';
import 'package:trivia/features/home/presentation/widgets/quiz_type.dart';
import 'package:trivia/features/home/presentation/widgets/user_ranking.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(top: 78.h,left: 27.w,right: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            SizedBox(height: 15.h,),
            const UserRanking(),
            SizedBox(height: 10.h,),
            const QuizType(),
            Reusable(text: "Let's Play",fontSize: 18.sp,),
            SizedBox(height: 10.h,),
            QuizCategory()

          ],
        ),
      ),
    );
  }
}
