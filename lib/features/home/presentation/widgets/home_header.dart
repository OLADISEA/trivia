import 'package:flutter/material.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Reusable(text: "Hi, Oladisea"),
            Reusable(text: "Let's make this day productive")
          ],
        ),
        Image.asset("assets/images/user-image.png")
      ],
    );
  }
}
