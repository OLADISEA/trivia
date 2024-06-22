import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trivia/features/auth/presentation/pages/login_page.dart';
import 'package:trivia/features/auth/presentation/widgets/submit_button.dart';


class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        return Center(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r)
              ),
              child: SubmitButton(text: 'Sign Out', color: Colors.white,textColor: Colors.black,width: 100.w,
                onTap: (){
                  context.read<AuthBloc>().add(LogoutRequested());
              },),
            )
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is AuthUnauthenticated){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginPage()));
        }
      },
    );
  }
}
