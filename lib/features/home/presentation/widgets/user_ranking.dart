import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/auth/data/shared_preference_helper.dart';
import 'package:trivia/features/ranking/bloc/ranking_bloc.dart';
import 'package:trivia/features/ranking/bloc/ranking_event.dart';
import 'package:trivia/features/ranking/bloc/ranking_state.dart';
import 'package:trivia/core/common/model/user_score.dart';

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
      context.read<RankingBloc>().add(FetchUserRankings());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is RankingLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RankingLoaded) {
          if (userId != null) {
            final userRank = _getUserRank(state.userScores, userId!);
            return _buildUserRanking(userRank);
          } else {
            return Center(child: Text('User ID is null'));
          }
        } else {
          return Center(child: Text('Failed to load rankings'));
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

  Widget _buildUserRanking(int rank) {
    return Container(
      padding: EdgeInsets.only(right: 15.w, left: 10.w),
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(-1, 1),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, -1),
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
          _userRanking(score: '30.10', description: 'Points', image: 'points.jpg'),
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
                textColor: Colors.lightBlue,
              )
            ],
          ),
        ),
      ],
    );
  }
}
