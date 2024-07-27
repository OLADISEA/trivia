import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatistics {
  final double lastGameScore;
  final double weeklyScore;
  final int weeklyRank;
  final double monthlyScore;
  final int monthlyRank;
  final double points;
  final Timestamp lastUpdateTimestamp;

  UserStatistics({
    required this.lastGameScore,
    required this.weeklyScore,
    required this.weeklyRank,
    required this.monthlyScore,
    required this.monthlyRank,
    required this.points,
    required this.lastUpdateTimestamp,
  });

  factory UserStatistics.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserStatistics(
      lastGameScore: data['recentScore'] ?? 0.0,
      weeklyScore: data['weeklyScore'] ?? 0.0,
      weeklyRank: data['weeklyRank'] ?? 0,
      monthlyScore: data['monthlyScore'] ?? 0.0,
      monthlyRank: data['monthlyRank'] ?? 0,
      points: data['points']?? 0.0,
      lastUpdateTimestamp: data['lastUpdateTimestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lastGameScore': lastGameScore,
      'weeklyScore': weeklyScore,
      'weeklyRank': weeklyRank,
      'monthlyScore': monthlyScore,
      'monthlyRank': monthlyRank,
      'points': points,
      'lastUpdateTimestamp': lastUpdateTimestamp,
    };
  }
}
