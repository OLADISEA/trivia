import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/features/auth/data/shared_preference_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesHelper _preferencesHelper = SharedPreferencesHelper();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': event.name,
        'email': event.email,
        'highScore': 0.0, // Initialize scores to 0
        'recentScore': 0.0,
        // 'weeklyScore': 0.0,
        // 'weeklyRank': 0, // Initialize weekly rank to 0
        // 'monthlyScore': 0.0, // Initialize monthly score to 0
        // 'monthlyRank': 0,
        'lastUpdateTimestamp': Timestamp.now(),
      });

      emit(AuthSignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        throw Exception('User data does not exist!');
      }

      await _preferencesHelper.saveUserId(userCredential.user!.uid);
      String userName = userDoc['name'];
      await _preferencesHelper.saveUserEmail(event.email);
      await _preferencesHelper.saveUserName(userName);

      // Fetch and save user scores
      double highScore = userDoc['highScore'];
      double recentScore = userDoc['recentScore'];
      // double weeklyScore = userDoc['weeklyScore'];
      // double lastGameScore = userDoc['recentScore'];

      await _preferencesHelper.saveHighScore(highScore);
      await _preferencesHelper.saveRecentScore(recentScore);
      // await _preferencesHelper.saveWeeklyScore(weeklyScore);
      // await _preferencesHelper.saveLastGameScore(lastGameScore);

      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    await _preferencesHelper.clearUserData();
    emit(AuthUnauthenticated());
  }
}
