import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/auth/presentation/widgets/submit_button.dart';
import 'package:trivia/features/auth/presentation/widgets/text_button.dart';
import 'package:trivia/features/auth/presentation/widgets/textfield.dart';

import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30.w,top: 50.h,right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/quiz-welcome.jpg",width: 200.w,height: 200.h,
                ),
              ),
              SizedBox(height: 50.h,),
              SizedBox(
                height: 70.h,
                  width: 125.w,
                  child: Reusable(text: "Forgot Password?",fontSize: 25.sp,textAlign: TextAlign.left,fontWeight: FontWeight.w500,)),
              SizedBox(height: 15.h,),
              Reusable(text: "Please enter the email address associated with your account",fontSize: 15.sp,textAlign: TextAlign.left),
              SizedBox(height: 10.h,),
              AuthTextField(controller: passwordController, text: "Password",obscureText: true,),
              SizedBox(height: 150.h,),
              const SubmitButton(text: "SUBMIT", color: Colors.lightBlue,textColor: Colors.white,),
              SizedBox(height: 100.h,),
        
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}
