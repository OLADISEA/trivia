import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';


class ProfileAction extends StatelessWidget {
  final String text;
  final IconData icon;
  const ProfileAction({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(1,2)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20.r,
              child: Icon(icon)
          ),
          SizedBox(width: 14.w,),
          Reusable(text: text,fontSize: 15.sp,)
        ],
      ),
    );
  }
}
