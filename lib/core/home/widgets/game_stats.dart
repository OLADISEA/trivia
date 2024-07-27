import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';

class GameStats extends StatelessWidget {
  final String statTitle;
  final String playerStat;
  const GameStats({Key? key, required this.statTitle, required this.playerStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Reusable(text: statTitle,fontSize: 18.sp,),
        SizedBox(width: 50.w,),
        Reusable(text: playerStat,fontSize: 15.sp,textColor: Colors.lightBlue,),

      ],
    );
  }
}
