import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/shared_preference_helper.dart';
import '../../../widgets/reusable_text.dart';
import '../../ranking/bloc/ranking_bloc.dart';
import '../../ranking/bloc/ranking_event.dart';
import '../../ranking/bloc/ranking_state.dart';


class HomeHeader extends StatefulWidget {
  HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? username;
  String? userImage;
  String? userEmail;
  String? userId;

  @override
  void initState() {
    super.initState();
    getUsernameAndImage();
  }

  Future<void> getUsernameAndImage() async {
    String? username = await SharedPreferencesHelper().getUserName();
    String? userImage = await SharedPreferencesHelper().getUserImageUrl();
    String? userEmail = await SharedPreferencesHelper().getUserEmail();
    String? userId = await SharedPreferencesHelper().getUserId();
    setState(() {
      this.username = username;
      this.userImage = userImage;
      this.userEmail = userEmail;
      this.userId = userId;
    });

    if (userId != null) {
      context.read<RankingBloc>().add(FetchUserRankings(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('the username is $username');
    }
    return Container(
      margin: EdgeInsets.only(left: 24.w,right: 24.w,top: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 25.r,
            //backgroundColor: Colors.transparent,
            backgroundImage: userImage != null
                ? NetworkImage(userImage!)
                : const AssetImage("assets/images/user-image.png")
            as ImageProvider<Object>,
            onBackgroundImageError: (error, stackTrace) {
              if (kDebugMode) {
                print('Error loading user image: $error');
              }
            },
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reusable(text: "Hi, $username",fontSize: 25.sp,fontWeight: FontWeight.w600,),
              Reusable(text: '${userEmail!.substring(0,8)}***.com',fontSize: 18.sp,textColor: Colors.white,)
            ],
          ),
          Expanded(child: SizedBox(width: 70.w,)),

          BlocBuilder<RankingBloc, RankingState>(
            builder: (context, state) {
              if (state is RankingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RankingLoaded) {
                if (userId != null) {
                  print(true);
                  print(state is UserPointsLoaded);

                  final userPoints = state.userPoints.toString();
                  return _buildUserRanking(userPoints);
                } else {
                  return const Center(child: Text('User ID is null'));
                }
              } else {
                return const Center(child: Text('Failed to load rankings'));
              }
            },
          )


        ],
      ),
    );
  }


  Widget _buildUserRanking(String points) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
      //height: 60.h,
      decoration: BoxDecoration(
        color: Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: _userRanking(
          score: points, description: 'Points', image: 'points.jpg'),
    );
  }
    Widget _userRanking({required String score, required String description, required String image}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/$image",
            width: 25.w,
          ),
          SizedBox(width: 8.w),
          Reusable(
              text: score,
              fontSize: 18.sp,
              textColor: const Color(0xff5bc2db),
            ),
        ],
      );
    }



}


