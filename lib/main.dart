import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/firebase_options.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theme_constants.dart';
import 'core/auth/bloc/auth_bloc.dart';
import 'core/home/bloc/user_stats_bloc.dart';
import 'core/progress_bar/bloc/progress_bloc.dart';
import 'core/quiz/bloc/quiz_bloc.dart';
import 'core/ranking/bloc/ranking_bloc.dart';
import 'core/settings/bloc/theme_bloc/theme_bloc.dart';
import 'core/settings/bloc/theme_bloc/theme_mode.dart';
import 'core/settings/bloc/theme_bloc/theme_state.dart';
import 'core/settings/bloc/user_image_bloc/image_bloc.dart';
import 'core/splash_screen/splash_screen.dart';
import 'data/quiz_repository.dart';
import 'data/shared_preference_helper.dart';
import 'data/user_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc(),
            ),
            BlocProvider(create: (context) => AuthBloc()),
            BlocProvider(create: (context) => QuizBloc(quizRepository: QuizRepository())),
            BlocProvider(create: (context)=> RankingBloc()),
            BlocProvider(create: (context)=> UserStatsBloc(UserService())),
            BlocProvider(create: (context)=> ProgressBloc()),
            BlocProvider(
              create: (context) => ImageBloc(FirebaseStorage.instance, FirebaseFirestore.instance,SharedPreferencesHelper()),
            ),
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
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          ThemeData themeData = themeState.status == AppThemeMode.light
              ? ThemeConstants.lightMode
              : ThemeConstants.darkMode;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeData,
              home: const SplashScreen(),
          );
        }
      ),
    );
  }
}
