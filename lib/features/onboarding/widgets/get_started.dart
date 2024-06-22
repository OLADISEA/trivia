import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';

import '../../auth/presentation/pages/login_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage())),
      child: Container(
        width: 180.w,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30)
        ),
        //margin: EdgeInsets.only(left: 20),
        //padding: EdgeInsets.only(left: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Reusable(text: "Get Started",textColor: Colors.white,),
              SizedBox(width: 5.w,),
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  shape: BoxShape.circle
                  ),
                  child: const Center(child: Icon(Icons.arrow_forward,color: Colors.black,)))
            ],
          ),
        ),
      ),
    );
  }
}
