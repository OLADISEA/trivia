import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/user_service.dart';
import 'user_stats_event.dart';
import 'user_stats_state.dart';

class UserStatsBloc extends Bloc<UserStatsEvent, UserStatsState> {
  final UserService userService;

  UserStatsBloc(this.userService) : super(UserStatsInitial()) {
    on<FetchUserStats>(_onFetchUserStats);
    on<SaveUserStats>(_onSaveUserStats);
  }

  Future<void> _onFetchUserStats(FetchUserStats event, Emitter<UserStatsState> emit) async {
    emit(UserStatsLoading());
    try {
      final stats = await userService.fetchUserStatistics(event.userId);
      emit(UserStatsLoaded(stats));
    } catch (e) {
      emit(UserStatsError(e.toString()));
    }
  }

  Future<void> _onSaveUserStats(SaveUserStats event, Emitter<UserStatsState> emit) async {
    emit(UserStatsLoading());
    try {
      await userService.saveUserStatistics(event.userId, event.stats);
      emit(UserStatsSaved());
    } catch (e) {
      emit(UserStatsError(e.toString()));
    }
  }
}
