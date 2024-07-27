import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/shared_preference_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesHelper _preferencesHelper = SharedPreferencesHelper();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(const AuthState()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ShowVisibility>(_showVisibility);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }


  void _showVisibility(ShowVisibility event, Emitter<AuthState> emit){
    emit(state.copyWith(isVisible: !state.isVisible));
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
        'weeklyScore': 0.0,
        'weeklyRank': 0, // Initialize weekly rank to 0
        // 'monthlyScore': 0.0, // Initialize monthly score to 0
        // 'monthlyRank': 0,
        'points': 0.0,
        'lastUpdateTimestamp': Timestamp.now(),
        'imageUrl': ""
      });

      emit(AuthSignUpSuccess());
    }on FirebaseAuthException catch (e) {

      if(e.code == "invalid-email") {
        emit(AuthError(e.toString()));
      }
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if(userCredential.user == null){
        emit(const AuthError("User does not exist"));

      }
      if(userCredential.user!.emailVerified){
        emit(const AuthError("You need to verify this email, check your mail box"));

      }
      //get the current user logged in
      var user = userCredential.user;
      if(user != null){

        //create a collection called users in the firebase
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
        double weeklyScore = userDoc['weeklyScore'];
        //double userPoints= userDoc['points'];

        await _preferencesHelper.saveHighScore(highScore);
        await _preferencesHelper.saveRecentScore(recentScore);
        await _preferencesHelper.saveWeeklyScore(weeklyScore);
        //await _preferencesHelper.saveUserPoints(userPoints);

        emit(AuthAuthenticated());
      }else{
        emit(const AuthError("You are not currently a user of this app"));
      }


    } on FirebaseAuthException catch (e) {
        String? error = _handleAuthException(e);
        emit(AuthError(error!));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    await _preferencesHelper.clearUserData();
    emit(AuthUnauthenticated());
  }

  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    try {
      emit(ForgotPasswordLoading());
      await _firebaseAuth.sendPasswordResetEmail(email: event.email);
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      String? error = _handleAuthException(e);
      emit(ForgotPasswordFailure(error!));
    }
  }

  String? _handleAuthException(FirebaseAuthException e){
    switch (e.code) {
      case 'invalid-email':
        return "The email address is not valid.";
      case 'user-disabled':
        return "This user has been disabled. Please contact support.";
      case 'user-not-found':
        return "No user found for this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'network-request-failed':
        return "Network error. Please check your internet connection.";
      default:
        return e.code.toString();
    }
  }
}
