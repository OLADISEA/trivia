import 'package:flutter/material.dart';


class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool? obscureText;
  const AuthTextField({super.key, required this.controller, required this.text, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      obscureText: obscureText??false,
      decoration: InputDecoration(
        suffixIcon: obscureText==true? Icon(Icons.visibility_off):null,
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5)
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.purpleAccent
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
