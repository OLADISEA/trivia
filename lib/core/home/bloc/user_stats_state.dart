import 'package:equatable/equatable.dart';

import '../../../model/user_statistics.dart';

abstract class UserStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserStatsInitial extends UserStatsState {}

class UserStatsLoading extends UserStatsState {}

class UserStatsLoaded extends UserStatsState {
  final UserStatistics stats;

  UserStatsLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}

class UserStatsSaved extends UserStatsState {}

class UserStatsError extends UserStatsState {
  final String message;

  UserStatsError(this.message);

  @override
  List<Object?> get props => [message];
}
