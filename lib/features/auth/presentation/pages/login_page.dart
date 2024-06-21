import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/common/widgets/reusable_text.dart';
import 'package:trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trivia/features/auth/presentation/pages/forgot_password.dart';
import 'package:trivia/features/auth/presentation/pages/register_page.dart';
import 'package:trivia/features/auth/presentation/widgets/submit_button.dart';
import 'package:trivia/features/auth/presentation/widgets/text_button.dart';
import 'package:trivia/features/auth/presentation/widgets/textfield.dart';

import '../../../nav_bar/nav_bar_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController emailController = TextEditingController();
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
              Reusable(text: "Login",fontSize: 25.sp,),
              SizedBox(height: 15.h,),
              AuthTextField(controller: emailController, text: "Email"),
              SizedBox(height: 10.h,),
              AuthTextField(controller: passwordController, text: "Password",obscureText: true,),
              SizedBox(height: 10.h,),
              Container(
                margin: EdgeInsets.only(left: 240.w),
                child: AppTextButton(text: "Forgot Password?",color: Colors.blueAccent,fontSize: 12.sp,
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ForgotPasswordPage()));
        
                },),
              ),
              SizedBox(height: 20.h,),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (BuildContext context, state) {
                  if(state is AuthLoading){
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  return SubmitButton(text: "LOGIN", color: Colors.lightBlue,textColor: Colors.white,
                      onTap: (){
                        context.read<AuthBloc>().add(LoginRequested(emailController.text, passwordController.text));
                      });
                },
                listener: (BuildContext context, Object? state) {
                  if(state is AuthAuthenticated){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NavBarPage()));
                  }
                  if(state is AuthError){
                    final error = state.message;
                    print(error);
                  }
                },
              ),
              SizedBox(height: 100.h,),
        
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Reusable(text: "New Here?",fontSize: 15.sp,),
                    AppTextButton(text: "Register", color: Colors.blueAccent,fontSize: 15.sp,onTap: (){
                      print(true);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> RegisterPage()));
        
                    },)
                  ],
                ),
              )
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}
