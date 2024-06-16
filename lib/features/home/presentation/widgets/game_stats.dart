import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';

class GameStats extends StatelessWidget {
  final String statTitle;
  final String playerStat;
  const GameStats({Key? key, required this.statTitle, required this.playerStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Reusable(text: statTitle),
        SizedBox(width: 20.w,),
        Reusable(text: playerStat),

      ],
    );
  }
}
