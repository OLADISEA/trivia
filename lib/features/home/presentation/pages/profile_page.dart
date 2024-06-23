import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/home/presentation/widgets/game_stats.dart';
import 'package:trivia/features/home/presentation/widgets/profile_action.dart';
import 'package:trivia/features/home/presentation/widgets/user_ranking.dart';
import 'package:trivia/features/settings/widgets/sign_out.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 31.h,vertical: 50.h),
        child: Column(
          children: [
            Reusable(text: "Profile",fontSize: 18.sp,),
            Image.asset("assets/images/user-image.png",),
            Reusable(text: "Oladisea",fontSize: 15.sp,),
            Reusable(text: "ladisea55@gmail.com",fontSize: 16.sp,),

            const UserRanking(),
            const GameStats(statTitle: "Last game score", playerStat: '19.75'),
            SizedBox(height: 15.h,),
            const GameStats(statTitle: "Weekly Score", playerStat: "30.10"),
            SizedBox(height: 15.h,),
            const GameStats(statTitle: "Weekly Rank", playerStat: '4'),
            SizedBox(height: 15.h,),
            const GameStats(statTitle: "Monthly score", playerStat: '30.10'),
            SizedBox(height: 15.h,),
            const GameStats(statTitle: "Monthly Rank", playerStat: '5'),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SignOut(),

                SizedBox(width: 15.w,),
                const ProfileAction(text: "Edit Profile", icon: Icons.edit)

              ],
            ),

          ],
        ),
      ),
    );
  }
}
