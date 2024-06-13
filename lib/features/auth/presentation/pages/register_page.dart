import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/auth/presentation/widgets/submit_button.dart';
import 'package:trivia/features/auth/presentation/widgets/text_button.dart';
import 'package:trivia/features/auth/presentation/widgets/textfield.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30.w,top: 50.h,right: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("assets/images/quiz-welcome.jpg",width: 200.w,height: 200.h,
              ),
            ),
            SizedBox(height: 50.h,),
            Reusable(text: "Sign up",fontSize: 25.sp,),
            SizedBox(height: 15.h,),
            AuthTextField(controller: nameController, text: "Name"),
            SizedBox(height: 10.h,),
            AuthTextField(controller: emailController, text: "Email"),
            SizedBox(height: 10.h,),
            AuthTextField(controller: passwordController, text: "Password",obscureText: true,),
            SizedBox(height: 10.h,),

            SizedBox(height: 20.h,),
            const SubmitButton(text: "SIGN UP", color: Colors.lightBlue),
            SizedBox(height: 100.h,),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Reusable(text: "Already have an account?",fontSize: 15.sp,),
                  AppTextButton(text: "Sign In", color: Colors.blueAccent,fontSize: 15.sp,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));

                  },
                  )
                ],
              ),
            )



          ],
        ),
      ),
    );
  }
}
