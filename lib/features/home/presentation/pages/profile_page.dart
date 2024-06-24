import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/home/presentation/widgets/game_stats.dart';
import 'package:trivia/features/home/presentation/widgets/profile_action.dart';
import 'package:trivia/features/home/presentation/widgets/user_ranking.dart';
import 'package:trivia/features/settings/widgets/sign_out.dart';

import '../../../auth/data/shared_preference_helper.dart';
import '../../data/user_service.dart';
import '../bloc/user_stats_bloc.dart';
import '../bloc/user_stats_event.dart';
import '../bloc/user_stats_state.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  String? userId;
  @override
  void initState() {
    getUserId();
    print('the user id is $userId');
    super.initState();
  }



  Future<void> getUserId() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    setState(() {
      this.userId = userId;
    });
    if(userId != null){
      context.read<UserStatsBloc>().add(FetchUserStats(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 31.h, vertical: 50.h),
          child: BlocBuilder<UserStatsBloc, UserStatsState>(
            builder: (context, state) {
              if (state is UserStatsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is UserStatsError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is UserStatsLoaded) {
                final stats = state.stats;
                return Column(
                  children: [
                    Reusable(text: "Profile", fontSize: 18.sp),
                    Image.asset("assets/images/user-image.png"),
                    Reusable(text: "Oladisea", fontSize: 15.sp),
                    Reusable(text: "ladisea55@gmail.com", fontSize: 16.sp),
                    const UserRanking(),
                    GameStats(statTitle: "Last game score", playerStat: stats.lastGameScore.toString()),
                    SizedBox(height: 15.h),
                    GameStats(statTitle: "Weekly Score", playerStat: stats.weeklyScore.toString()),
                    SizedBox(height: 15.h),
                    GameStats(statTitle: "Weekly Rank", playerStat: stats.weeklyRank.toString()),
                    SizedBox(height: 15.h),
                    GameStats(statTitle: "Monthly score", playerStat: stats.monthlyScore.toString()),
                    SizedBox(height: 15.h),
                    GameStats(statTitle: "Monthly Rank", playerStat: stats.monthlyRank.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SignOut(),
                        SizedBox(width: 15.w),
                        const ProfileAction(text: "Edit Profile", icon: Icons.edit),
                      ],
                    ),
                  ],
                );
              }
              return Container(); // Default case, shouldn't happen
            },
          ),
        ),
      ),
    );
  }
}
