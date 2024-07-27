import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OnboardingPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/quiz-logo3.png"),
                  // QuizLogo(text: "Q", text1: 'U',),
                  // SizedBox(height: 5,),
                  // QuizLogo(text: "I", text1: "Z")
                ],
              ),
            ),
          ),
        );
      }
    }







