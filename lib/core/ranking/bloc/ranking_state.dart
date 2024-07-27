import 'package:equatable/equatable.dart';

import '../../../model/user_score.dart';


abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object?> get props => [];
}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  final List<UserScore> userScores;
  final double userPoints;

  RankingLoaded(this.userScores, this.userPoints);


}

class WeeklyRankLoaded extends RankingState {
  final List<UserScore> userScores;

  WeeklyRankLoaded(this.userScores);


}

class UserPointsLoaded extends RankingState {
  final double userPoints;

  UserPointsLoaded(this.userPoints);
}


class RankingError extends RankingState {
  final String message;

  RankingError(this.message);

  @override
  List<Object?> get props => [message];
}
