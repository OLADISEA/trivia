import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/shared_preference_helper.dart';
import '../../../model/user_score.dart';
import '../../../widgets/reusable_text.dart';
import '../../ranking/bloc/ranking_bloc.dart';
import '../../ranking/bloc/ranking_event.dart';
import '../../ranking/bloc/ranking_state.dart';

class UserRanking extends StatefulWidget {
  const UserRanking({super.key});

  @override
  State<UserRanking> createState() => _UserRankingState();
}

class _UserRankingState extends State<UserRanking> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    setState(() {
      this.userId = userId;
    });
    if (userId != null) {
      context.read<RankingBloc>().add(FetchUserRankings(userId: userId));
      //context.read<RankingBloc>().add(FetchUserPoints(userId: userId)); // Fetch user points
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is RankingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RankingLoaded) {
          if (userId != null) {
            print(true);
            print(state is UserPointsLoaded);
            final userRank = _getUserRank(state.userScores, userId!);
            final userPoints = state.userPoints.toString();
            return _buildUserRanking(userRank, userPoints);
          } else {
            return const Center(child: Text('User ID is null'));
          }
        } else {
          return const Center(child: Text('Failed to load rankings'));
        }
      },
    );
  }

  int _getUserRank(List<UserScore> userScores, String userId) {
    for (int i = 0; i < userScores.length; i++) {
      if (userScores[i].userId == userId) {
        return i + 1; // Rankings are 1-based
      }
    }
    return -1; // User not found
  }

  Widget _buildUserRanking(int rank, String points) {
    return Container(
      padding: EdgeInsets.only(right: 15.w, left: 10.w),
      height: 60.h,
      decoration: BoxDecoration(
        color: Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-1, 1),
          ),
          BoxShadow(
            color: Color(0xffe7e7e7),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, -1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _userRanking(score: '$rank', description: 'Ranking', image: 'rank.jpg'),
          VerticalDivider(
            color: Colors.grey.withOpacity(0.5),
            endIndent: 10,
            indent: 10,
          ),
          _userRanking(score: points, description: 'Points', image: 'points.jpg'),
        ],
      ),
    );
  }

  Widget _userRanking({required String score, required String description, required String image}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.r,
          child: Image.asset(
            "assets/images/$image",
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reusable(
                text: description,
                fontSize: 20.sp,
              ),
              Reusable(
                text: score,
                fontSize: 18.sp,
                textColor: const Color(0xff5bc2db),
              )
            ],
          ),
        ),
      ],
    );
  }
}
