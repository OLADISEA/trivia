import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/home/presentation/widgets/game_stats.dart';
import 'package:trivia/features/home/presentation/widgets/profile_action.dart';
import 'package:trivia/features/home/presentation/widgets/user_ranking.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Reusable(text: "Profile"),
            Image.asset("assets/images/user-image.png"),
            Reusable(text: "Oladisea"),
            Reusable(text: "ladisea55@gmail.com"),

            const UserRanking(),
            const GameStats(statTitle: "Last game score", playerStat: '19.75'),
            const GameStats(statTitle: "Weekly Score", playerStat: "30.10"),
            const GameStats(statTitle: "Weekly Rank", playerStat: '4'),
            const GameStats(statTitle: "Monthly score", playerStat: '30.10'),
            const GameStats(statTitle: "Monthly Rank", playerStat: '5'),


            Row(
              children: [
                ProfileAction(text: "Sign Out", icon: Icons.logout_rounded),

                SizedBox(width: 15.w,),
                ProfileAction(text: "Edit Proifle", icon: Icons.edit)

              ],
            ),

          ],
        ),
      ),
    );
  }
}
