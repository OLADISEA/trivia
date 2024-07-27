import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth/widgets/submit_button.dart';

class QuizType extends StatelessWidget {
  const QuizType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SubmitButton(text: "Random Quiz", color: Colors.blueAccent,textColor: Colors.white,width: 160.w,),
        SizedBox(width: 10.w,),
        SubmitButton(text: "Custom Quiz", color: Colors.blueAccent,textColor: Colors.white,width: 160.w,)

      ],
    );
  }
}
