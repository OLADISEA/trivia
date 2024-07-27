import 'package:flutter/material.dart';

import '../../../widgets/reusable_text.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final void Function()? onTap;
  const AppTextButton({super.key, required this.text, this.onTap, required this.color, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Reusable(text: text,textColor: color,fontSize: fontSize,)
    );
  }
}
