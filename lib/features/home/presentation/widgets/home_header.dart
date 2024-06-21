import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/auth/data/shared_preference_helper.dart';


class HomeHeader extends StatefulWidget {
  HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    String? username = await SharedPreferencesHelper().getUserName();
    print(username);
    setState(() {
      this.username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('the username is $username');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Reusable(text: "Hi, $username",fontSize: 25.sp,fontWeight: FontWeight.w600,),
            Reusable(text: "Let's make this day productive",fontSize: 18.sp,)
          ],
        ),
        CircleAvatar(
          radius: 22.r,
            child: Image.asset("assets/images/user-image.png"))
      ],
    );
  }
}
