import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/ranking/screens/all_time.dart';

import '../../widgets/back_arrow.dart';
import '../../widgets/notification.dart';
import '../../widgets/reusable_text.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  int _selectedIndex = 0;

  List<String> segments = ["All Time", "This Week", "This Month"];

  List<Widget> contentWidgets = [
    const AllTimeRanking(),
    Container(
      color: Colors.greenAccent.withOpacity(0.5),
      child: Center(
        child: Reusable(text: "This Week Content"),
      ),
    ),
    Container(
      color: Colors.blueAccent.withOpacity(0.5),
      child: Center(
        child: Reusable(text: "This Month Content"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(top: 30.h, left: 27.w,right: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(),
                CustomNotification()
              ],
            ),
            SizedBox(height: 5.h),
            Reusable(
              text: 'Leader Board',
              fontSize: 22.sp,
            ),
            SizedBox(height: 10.h),

            // Custom Segmented Control
            Flexible(
              child: Container(

                margin: EdgeInsets.only(left: 2.w),
                width: 330.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r)
                ),
                child: Stack(
                  children: [
                    // Background decoration for the selected segment
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left: _selectedIndex * (340.w / segments.length),
                      child: Container(
                        width: 310.w / segments.length,
                        height: 49.h,
                        decoration: BoxDecoration(
                          border: const Border(
                            top: BorderSide(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                          //borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Segment texts
                    Row(
                      children: segments.map((String segment) {
                        int index = segments.indexOf(segment);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: 400 / segments.length,
                            height: 50.h,
                            alignment: Alignment.center,
                            child: Reusable(
                              text: segment,
                              fontSize: 16.sp,
                              textColor: _selectedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80.h),

            // Content based on selected tab
            Expanded(
              child: contentWidgets[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
