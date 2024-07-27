import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/shared_preference_helper.dart';
import '../../../widgets/reusable_text.dart';


class HomeHeader extends StatefulWidget {
  HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? username;
  String? userImage;

  @override
  void initState() {
    super.initState();
    getUsernameAndImage();
  }

  Future<void> getUsernameAndImage() async {
    String? username = await SharedPreferencesHelper().getUserName();
    String? userImage = await SharedPreferencesHelper().getUserImageUrl();
    print(username);
    setState(() {
      this.username = username;
      this.userImage = userImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('the username is $username');
    }
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
          radius: 30.r,
            backgroundImage: userImage != null
                ?NetworkImage(userImage!)
                :const AssetImage("assets/images/user-image.png") as ImageProvider<Object>
        )
      ],
    );
  }
}
