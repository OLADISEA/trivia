import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTimeRanking extends StatelessWidget {
  const AllTimeRanking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
      children: [
        bestThree(),
        SizedBox(height: 20.h,),
        Expanded(
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.red,
               borderRadius: BorderRadius.circular(20.r)
            ),
            //color: Colors.red,
          ),
        )
      ],
    ));
  }

  Widget bestThree(){
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 340.w,
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        Positioned(
          left: 100.w,
          right: 100.w,
          bottom: 0.h,
          child: Container(
            height: 250.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.r),
                  topRight: Radius.circular(60.r)
              ),
            ),
          ),
        ),

      ],
    );
  }
}

