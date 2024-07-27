import 'package:equatable/equatable.dart';

abstract class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserRankings extends RankingEvent {
  final String userId;
  FetchUserRankings({required this.userId});
}

class FetchUserWeeklyRank extends RankingEvent{}

class FetchUserPoints extends RankingEvent {
  final String userId;

  FetchUserPoints({required this.userId});
}
