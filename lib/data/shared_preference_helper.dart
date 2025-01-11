import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Keys for SharedPreferences
  static const String userIdKey = "user_id";
  static const String _userEmailKey = "email_key";
  static const String _userNameKey = "username_key";
  static const String highScoreKey = 'highScore';
  static const String recentScoreKey = 'recentScore';
  static const String weeklyScoreKey = 'weeklyScore';
  static const String weeklyHighScoreKey = 'weeklyHighScore';
  static const String userPointKey = 'userPoints';
  static const String lastGameScoreKey = 'lastGameScore';
  static const String userImageUrlKey = 'userImageUrl';

  // Private constructor
  SharedPreferencesHelper._privateConstructor();

  // The single instance of the class
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._privateConstructor();

  // Factory constructor
  factory SharedPreferencesHelper() {
    return _instance;
  }

  // Ensure SharedPreferences is initialized
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save userId
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setString(userIdKey, userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getString(userIdKey);
  }

  // Save user email
  Future<void> saveUserEmail(String email) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setString(_userEmailKey, email);
  }

  // Get user email
  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await _getPrefs();
    return prefs.getString(_userEmailKey);
  }

  // Save user name
  Future<void> saveUserName(String name) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setString(_userNameKey, name);
  }

  // Get user name
  Future<String?> getUserName() async {
    final SharedPreferences prefs = await _getPrefs();
    return prefs.getString(_userNameKey);
  }

  // Save user high score
  Future<void> saveHighScore(double score) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setDouble(highScoreKey, score);
  }

  // Save user recent score
  Future<void> saveRecentScore(double score) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setDouble(recentScoreKey, score);
  }

  // Save user weekly score
  Future<void> saveWeeklyScore(double score) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setDouble(weeklyScoreKey, score);
  }

  // Save user points
  Future<void> saveUserPoints(double points) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setDouble(userPointKey, points);
  }

  // Get user points
  Future<double?> getUserPoints() async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getDouble(userPointKey);
  }

  // Save user image URL
  Future<void> saveUserImageUrl(String imageUrl) async {
    SharedPreferences prefs = await _getPrefs();
    await prefs.setString(userImageUrlKey, imageUrl);
  }

  // Get user image URL
  Future<String?> getUserImageUrl() async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getString(userImageUrlKey);
  }

  // Remove user data
  Future<void> clearUserData() async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.clear();
  }
}















// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesHelper {
//   static const String userIdKey = "user_id";
//   static const String _userEmailKey = "email_key";
//   static const String _userNameKey = "username_key";
//   static const String highScoreKey = 'highScore';
//   static const String recentScoreKey = 'recentScore';
//   static const String weeklyScoreKey = 'weeklyScore';
//   static const String weeklyHighScoreKey = 'weeklyHighScore';
//   static const String userPointKey = 'userPoints';
//   static const String lastGameScoreKey = 'lastGameScore';
//   static const String userImageUrlKey = 'userImageUrl';
//
//   // Save userId
//   Future<void> saveUserId(String userId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(userIdKey, userId);
//   }
//
//   Future<String?> getUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(userIdKey);
//   }
//
//   // Save user email
//   Future<void> saveUserEmail(String email) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userEmailKey, email);
//   }
//
//   // Get user email
//   Future<String?> getUserEmail() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userEmailKey);
//   }
//
//   // Save user name
//   Future<void> saveUserName(String name) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userNameKey, name);
//   }
//
//   // Get user name
//   Future<String?> getUserName() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userNameKey);
//   }
//
//   // Save user high score
//   Future<void> saveHighScore(double score) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setDouble(highScoreKey, score);
//   }
//
//   // Save user recent score
//   Future<void> saveRecentScore(double score) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setDouble(recentScoreKey, score);
//   }
//
//   // Save user weekly score
//   Future<void> saveWeeklyScore(double score) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setDouble(weeklyScoreKey, score);
//   }
//
//   // Save user points
//   Future<void> saveUserPoints(double points) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setDouble(userPointKey, points);
//   }
//
//   // Get user points
//   Future<double?> getUserPoints() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getDouble(userPointKey);
//   }
//
//   // Save user image URL
//   Future<void> saveUserImageUrl(String imageUrl) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(userImageUrlKey, imageUrl);
//   }
//
//   // Get user image URL
//   Future<String?> getUserImageUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(userImageUrlKey);
//   }
//
//   // Remove user data
//   Future<void> clearUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }
