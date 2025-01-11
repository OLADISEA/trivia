import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trivia/data/facts_data.dart';
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

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FactService _factService = FactService();

  void initState(){
    super.initState();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages here
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }


    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Message clicked!');
      }
    });

    tz.initializeTimeZones();
    _scheduleDailyNotification();
  }



  void _scheduleDailyNotification() async {
    final String fact = await _factService.getRandomFact();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Did You Know?',
      fact,
      _nextInstanceOf10AM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily_notification_description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOf10AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }
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
