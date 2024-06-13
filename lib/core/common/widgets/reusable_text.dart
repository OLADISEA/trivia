import 'package:flutter/material.dart';

class Reusable extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  const Reusable({super.key, required this.text, this.fontSize, this.textColor, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign??TextAlign.center,
      style: TextStyle(
        fontSize: fontSize?? 15,
        color: textColor?? Colors.black
      ),
    );
  }
}
