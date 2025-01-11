import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';


class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  const AuthTextField({super.key, required this.controller, required this.text, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      obscureText: text == "Password"?!obscureText:false,
      decoration: InputDecoration(
        suffixIcon: text == "Password"
            ? IconButton(
          onPressed: () {
            print('i was pressed');
            print('the obscure text is $obscureText');
            context.read<AuthBloc>().add(ShowVisibility(isVisible: obscureText));
          },
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        )
            : null,
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
