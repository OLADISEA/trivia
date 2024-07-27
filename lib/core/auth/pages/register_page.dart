import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/flutter_toast.dart';
import '../../../widgets/reusable_text.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/submit_button.dart';
import '../widgets/text_button.dart';
import '../widgets/textfield.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc,AuthState>(
        
          builder: (BuildContext context, AuthState state) {
            if(state is AuthLoading){
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
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

                  BlocBuilder<AuthBloc,AuthState>(
                    builder: (BuildContext context, state) {
                      return AuthTextField(
                        controller: passwordController,
                        text: "Password",
                        obscureText: state.isVisible,
                      );
                    },
                  ),
                  SizedBox(height: 10.h,),
        
                  SizedBox(height: 20.h,),
                  SubmitButton(text: "SIGN UP", color: Colors.lightBlue,textColor: Colors.white,onTap: (){
                    context.read<AuthBloc>().add(SignUpRequested(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text));
                  },),
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
            );
          },
          listener: (BuildContext context, AuthState state) async{
            if(state is AuthSignUpSuccess){
              nameController.clear();
              passwordController.clear();
              emailController.clear();
              await toastInfo(msg: "Sign up Successful, please sign in");
              print("Successful");
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
            }
          },
        
        ),
      ),
    );
  }
}
