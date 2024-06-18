import 'package:flutter/material.dart';

class QuizLogo extends StatelessWidget {
  final String text;
  final String text1;
  const QuizLogo({super.key, required this.text, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(5)
          ),
          height: 40,
          width: 40,
          child: Center(child: Text(text)),
        ),
        SizedBox(width: 5,),
        Container(
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(5)
          ),

          height: 40,
          width: 40,
          child: Center(child: Text(text1)),
        ),
      ],
    );
  }
}
