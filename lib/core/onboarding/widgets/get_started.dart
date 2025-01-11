import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';
import '../../auth/pages/login_page.dart';


class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage())),
      child: Container(
        width: 230.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Color(0xFF7F39FB),
          borderRadius: BorderRadius.circular(30)
        ),
        //margin: EdgeInsets.only(left: 20),
        //padding: EdgeInsets.only(left: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Reusable(text: "Get Started",textColor: Colors.white,fontSize: 15.sp,),
              SizedBox(width: 8.w,),
              const Center(child: Icon(Icons.arrow_forward,color: Colors.white,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
