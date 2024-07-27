import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xffffffff),
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Color(0XFF342F3F),
      tertiary: Colors.grey.shade600,
      onPrimary: Colors.black,
      onError: Colors.black,
      onSecondary: Colors.white
    ),
  );

  static ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
        background: Color(0XFF1D182A),
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        inversePrimary: Color(0XFF342F3F),
        tertiary: Color(0XFF342F3F),
        onPrimary: Color(0xffffffff),
        onError: Colors.white,
        onSecondary: Colors.white

    ),
  );
}




// import 'package:flutter/material.dart';
//
// class AppTheme {
//   static final AppTheme _instance = AppTheme._internal();
//
//   factory AppTheme() {
//     return _instance;
//   }
//
//   AppTheme._internal();
//
//   static ThemeData lightTheme = ThemeData(
//     primaryColor: Colors.grey.shade500,
//     hintColor: Colors.grey.shade200,
//     backgroundColor: Color(0xffffffff),
//     scaffoldBackgroundColor: Color(0xffffffff),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: Colors.black),
//       bodyText2: TextStyle(color: Colors.black),
//     ),
//     appBarTheme: AppBarTheme(
//       color: Colors.grey.shade500,
//       titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
//
//     ),
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.grey.shade500,
//       textTheme: ButtonTextTheme.primary,
//     ),
//     // Define other custom properties here
//   );
//
//   static ThemeData darkTheme = ThemeData(
//     primaryColor: Colors.grey.shade600,
//     hintColor: Colors.grey.shade800,
//     backgroundColor: Color(0XFF1D182A),
//     scaffoldBackgroundColor: Color(0XFF1D182A),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: Colors.white),
//       bodyText2: TextStyle(color: Colors.white),
//     ),
//     appBarTheme: AppBarTheme(
//       color: Colors.grey.shade600,
//       titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
//
//     ),
//     buttonTheme: ButtonThemeData(
//       buttonColor: Colors.grey.shade600,
//       textTheme: ButtonTextTheme.primary,
//     ),
//     // Define other custom properties here
//   );
//
//
// }
//
