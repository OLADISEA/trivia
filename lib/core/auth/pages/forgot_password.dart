import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/reusable_text.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/submit_button.dart';
import '../widgets/textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30.w, top: 50.h, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/quiz-welcome.jpg",
                  width: 200.w,
                  height: 200.h,
                ),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                height: 70.h,
                width: 125.w,
                child: Reusable(
                  text: "Forgot Password?",
                  fontSize: 25.sp,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.h),
              Reusable(
                text: "Please enter the email address associated with your account",
                fontSize: 15.sp,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.h),
              AuthTextField(
                controller: emailController,
                text: "Email",
                obscureText: false,
              ),
              SizedBox(height: 150.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password reset email sent!')),
                    );
                    Navigator.of(context).pop();
                  } else if (state is ForgotPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SubmitButton(
                    text: "SUBMIT",
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    onTap: () {
                      context.read<AuthBloc>().add(
                        ForgotPasswordRequested(emailController.text),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}














