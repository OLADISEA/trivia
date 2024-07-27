import 'package:flutter/material.dart';

class Reusable extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const Reusable({super.key, required this.text, this.fontSize, this.textColor, this.textAlign, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign??TextAlign.start,
      style: TextStyle(
        fontWeight: fontWeight??FontWeight.normal,
        fontSize: fontSize?? 15,
        color: textColor?? Colors.black
      ),
    );
  }
}
