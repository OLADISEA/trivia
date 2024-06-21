
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:trivia/features/ranking/bloc/ranking_bloc.dart';
import 'package:trivia/firebase_options.dart';

import 'features/quiz/bloc/quiz_bloc.dart';
import 'features/quiz/data/quiz_repository.dart';
import 'features/splash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthBloc()),
            BlocProvider(create: (context) => QuizBloc(quizRepository: QuizRepository())),
            BlocProvider(create: (context)=> RankingBloc())
          ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
