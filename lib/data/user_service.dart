import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_statistics.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserStatistics> fetchUserStatistics(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserStatistics.fromFirestore(doc);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch user stats: $e');
    }
  }

  Future<void> saveUserStatistics(String userId, UserStatistics stats) async {
    try {
      await _firestore.collection('users').doc(userId).set(stats.toMap());
    } catch (e) {
      throw Exception('Failed to save user stats: $e');
    }
  }
}
