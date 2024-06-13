import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';

class UserRanking extends StatelessWidget {
  const UserRanking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15.w,left: 10.w),
      height: 50.h,
      //width: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _userRanking(score: '5', description: 'Ranking', image: 'rank.jpg'),
          VerticalDivider(
            color: Colors.grey.withOpacity(0.5),
            endIndent: 10,
            indent: 10,

          ),
          _userRanking(score: '30.10', description: 'Points', image: 'points.jpg')
        ],
      ),
    );
  }


  Widget _userRanking({required String score, required String description, required String image}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        CircleAvatar(
            child: Image.asset("assets/images/$image"),

        ),
        SizedBox(width: 8.w),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reusable(text: description),
              Reusable(text: score)
            ],
          ),
        )
      ],
    );
  }
}
