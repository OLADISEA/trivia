import 'package:flutter_bloc/flutter_bloc.dart';
import 'progress_event.dart';
import 'progress_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressInitial()) {
    on<FetchProgress>(_onFetchProgress);
    on<UpdateProgress>(_onUpdateProgress);
  }

  Future<void> _onFetchProgress(FetchProgress event, Emitter<ProgressState> emit) async {
    emit(ProgressLoading());
    try {
      final progress = await fetchUserProgress(event.userId);
      print("success loading the progress points");
      print(progress);
      emit(ProgressLoaded(progress));
    } catch (error) {
      emit(ProgressError('Failed to fetch progress'));
    }
  }

  Future<void> _onUpdateProgress(UpdateProgress event, Emitter<ProgressState> emit) async {
    emit(ProgressLoading());
    try {
      await updateUserProgress(event.progress);
      print("sucees loading the progress points");
      emit(ProgressLoaded(event.progress));
    } catch (error) {
      emit(const ProgressError('Failed to update progress'));
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserProgress(String userId) async {
    try {
      // Fetch user progress from Firestore
      final userScoresCollection = FirebaseFirestore.instance.collection('user_scores').doc(userId).collection('scores');

      // Query to get the last 7 scores, order by timestamp descending
      final querySnapshot = await userScoresCollection.orderBy('timestamp', descending: true).limit(7).get();

      final progress = querySnapshot.docs.asMap().entries.map((entry) {
        final index = entry.key + 1;
        return {
          'x': index,
          'score': entry.value.data()['score'],
        };
      }).toList();

      print('Number of documents fetched: ${querySnapshot.docs.length}');
      print('Documents fetched: ${querySnapshot.docs}');
      return progress;
    } catch (error) {
      print('Error fetching user progress: $error');
      throw error; // Optionally, handle the error as needed
    }
  }



  Future<void> updateUserProgress(List<Map<String, dynamic>> progress) async {
    // Implement your logic to update user progress
  }
}
