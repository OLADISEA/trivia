import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/auth/pages/register_page.dart';

import '../../../widgets/flutter_toast.dart';
import '../../../widgets/reusable_text.dart';
import '../../nav_bar/nav_bar_page.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/submit_button.dart';
import '../widgets/text_button.dart';
import '../widgets/textfield.dart';
import 'forgot_password.dart';

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

              BlocBuilder<AuthBloc,AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    print("the visibility state is ${state.isVisible}");
                    return AuthTextField(
                      controller: passwordController,
                      text: "Password",
                      obscureText: state.isVisible,);

                  }),
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
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(LoginRequested(emailController.text, passwordController.text));
                      });
                },
                listener: (BuildContext context, Object? state) async{
                  if(state is AuthAuthenticated){
                    emailController.clear();
                    passwordController.clear();
                    await toastInfo(msg: "Login Successful");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> NavBarPage()));
                  }
                  if(state is AuthError){
                    toastInfo(msg: state.message);
                  }
                },
              ),
              SizedBox(height: 100.h,),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Reusable(text: "New Here? ",fontSize: 15.sp,),
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
