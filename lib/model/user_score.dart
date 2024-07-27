import 'package:cloud_firestore/cloud_firestore.dart';

class UserScore {
  final String userId;
  final String userName;
  final double highScore;
  final String imageUrl;
  final double recentScore;

  UserScore({
    required this.userId,
    required this.userName,
    required this.highScore,
    required this.imageUrl,
    required this.recentScore,
  });

  factory UserScore.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserScore(
      userId: doc.id,
      userName: data['name'] ?? '',
      highScore: data['highScore'] ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      recentScore: data['recentScore'] ?? 0.0,
    );
  }
}
