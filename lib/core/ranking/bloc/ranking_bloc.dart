import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/user_score.dart';
import 'ranking_event.dart';
import 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  RankingBloc() : super(RankingInitial()) {
    on<FetchUserRankings>(_onFetchUserRankings);
    on<FetchUserWeeklyRank>(_onFetchWeeklyRank);
  }

  void _onFetchUserRankings(
      FetchUserRankings event,
      Emitter<RankingState> emit
      ) async {
    emit(RankingLoading());
    try {
      double userPoints = 0.0;
      final userScores = await _fetchUserScores();

      if (event.userId.isNotEmpty) {
        final doc = await _firestore.collection('users').doc(event.userId).get();
        if (doc.exists) {
          userPoints = doc['points'];
        }
      } else {
        userPoints = 0.0;
      }

      for (var userScore in userScores) {
        print('Username: ${userScore.userName}');
        if (userScore.imageUrl.isNotEmpty) {
          print('Image URL: ${userScore.imageUrl}');
        } else {
          print('Image URL: Not available');
        }
      }

      emit(RankingLoaded(userScores, userPoints));
    } catch (e) {
      emit(RankingError('Failed to fetch user rankings'));
    }
  }

  void _onFetchWeeklyRank(
      FetchUserWeeklyRank event,
      Emitter<RankingState> emit
      ) async {
    emit(RankingLoading());
    try {
      final weeklyRanks = await _fetchWeeklyRank();

      emit(WeeklyRankLoaded(weeklyRanks));
    } catch (e) {
      print('Failed to fetch weekly rank');
      emit(RankingError('Failed to fetch weekly ranks'));
    }
  }




  Future<List<UserScore>> _fetchUserScores() async {
    try {
      final querySnapshot = await _firestore.collection('users').orderBy(
          'highScore', descending: true).get();
      print(querySnapshot.docs);
      return querySnapshot.docs.map((doc) => UserScore.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching user scores: $e'); // Log the error
      rethrow; // Re-throw the error to be caught in the calling function
    }
  }




  Future<List<UserScore>> _fetchWeeklyRank() async {
    try {
      final querySnapshot = await _firestore.collection('users').orderBy(
          'weeklyRank', descending: true).get();
      return querySnapshot.docs.map((doc) => UserScore.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching weekly ranks: $e');
      throw e;
    }
  }
}
