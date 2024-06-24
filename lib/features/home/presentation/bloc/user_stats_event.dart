import 'package:equatable/equatable.dart';
import 'package:trivia/core/common/model/user_statistics.dart';

abstract class UserStatsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserStats extends UserStatsEvent {
  final String userId;

  FetchUserStats(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SaveUserStats extends UserStatsEvent {
  final String userId;
  final UserStatistics stats;

  SaveUserStats(this.userId, this.stats);

  @override
  List<Object?> get props => [userId, stats];
}
