import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/common/model/user_score.dart';
import 'ranking_event.dart';
import 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RankingBloc() : super(RankingInitial()) {
    on<FetchUserRankings>(_onFetchUserRankings);
  }

  void _onFetchUserRankings(FetchUserRankings event, Emitter<RankingState> emit) async {
    emit(RankingLoading());
    try {
      final userScores = await _fetchUserScores();
      emit(RankingLoaded(userScores));
    } catch (e) {
      print('Failed to fetch user rankings: $e'); // Log the error
      emit(RankingError('Failed to fetch user rankings'));
    }
  }

  Future<List<UserScore>> _fetchUserScores() async {
    try {
      final querySnapshot = await _firestore.collection('users').orderBy('highScore', descending: true).get();
      print(querySnapshot.docs);
      return querySnapshot.docs.map((doc) => UserScore.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching user scores: $e'); // Log the error
      rethrow; // Re-throw the error to be caught in the calling function
    }
  }
}
