import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/core/quiz/bloc/quiz_event.dart';
import 'package:trivia/core/quiz/bloc/quiz_state.dart';

import '../../../data/quiz_repository.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Timer? _timer;
  int _userScore = 0;
  double _userPoints = 0;
  String difficulty = '';


  QuizBloc({required this.quizRepository}) : super(const QuizState()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<SelectAnswer>(_onSelectAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<UpdateTimer>(_onUpdateTimer);
    on<UpdateUserScore>(_updateUserScore);
    on<ResetQuiz>(_onResetQuiz);
    on<UpdateWeeklyRank>(_onUpdateWeeklyRank);

  }

  Future<void> _onLoadQuestions(LoadQuestions event, Emitter<QuizState> emit) async {
    try {
      // Reset score and timer when loading new questions
      resetScore();
      _timer?.cancel();

      difficulty = event.difficulty!;
      final questions = await quizRepository.fetchQuestions(
        amount: event.amount,
        category: event.category,
        difficulty: event.difficulty,
        type: event.type,
        encoding: event.encoding,
      );
      if(questions.isEmpty){
        emit(QuizStateError("The questions available is less than ${event.amount}"));
      }

      // Initialize userAnswers with the correct length and null values
      final newUserAnswers = List<String?>.filled(questions.length, null);

      print("The bloc state has the set of questions");
      print(questions.length);
      final newState = state.copyWith(
          questions: questions,
          currentQuestionIndex: 0, // Reset to the first question
          remainingTime: 30, // Reset remaining time for new questions
          userAnswers: newUserAnswers
      );
      emit(newState);

      // Print after emitting the new state
      print('The number of questions is ${newState.questions.length}');
      _startTimer(); // Start the timer when questions are loaded
    } catch (e) {
      emit(QuizStateError(e.toString()));
    }
  }

  void _onSelectAnswer(SelectAnswer event, Emitter<QuizState> emit) {
    final isCorrect = event.answer == state.questions[state.currentQuestionIndex].correctAnswer;
    final updatedScore = isCorrect ? _userScore + 1 : _userScore;

    // Update userAnswers for the current question
    List<String?> newUserAnswers = List.from(state.userAnswers);
    newUserAnswers[state.currentQuestionIndex] = event.answer;

    if (isCorrect) {
      _userPoints += _calculatePoints();
    }

    emit(state.copyWith(
      selectedAnswer: event.answer,
      correctAnswer: isCorrect ? event.answer : state.questions[state.currentQuestionIndex].correctAnswer,
      userAnswers: newUserAnswers,
    ));
    _userScore = updatedScore;
  }

  num _calculatePoints() {
    //final question = state.questions[state.currentQuestionIndex];
    num basePoints = _getBasePointsForDifficulty(difficulty);
    double streakBonus = _getStreakBonus();
    double timeBonus = state.remainingTime > 20? 0.01: 0.0;

    print('the points is ${basePoints + streakBonus + timeBonus}');

    return basePoints + streakBonus + timeBonus;
  }

  num _getBasePointsForDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 0.01;
      case 'medium':
        return 0.02;
      case 'hard':
        return 0.05;
      default:
        return 0.03;
    }
  }

  double _getStreakBonus() {
    int streakCount = 0;
    for (int i = state.currentQuestionIndex - 1; i >= 0; i--) {
      if (state.userAnswers[i] == state.questions[i].correctAnswer) {
        streakCount++;
      } else {
        break;
      }
    }
    return streakCount * 0.01;
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedAnswer: null,
        correctAnswer: null,
        remainingTime: 30,
      ));
      _startTimer(); // Restart the timer for the next question
    }
  }

  void _onUpdateTimer(UpdateTimer event, Emitter<QuizState> emit) {
    emit(state.copyWith(remainingTime: event.remainingTime));
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        add(UpdateTimer(state.remainingTime - 1));
      } else {
        if (state.currentQuestionIndex < state.questions.length - 1) {
          add(NextQuestion());
        } else {
          timer.cancel();
          // Handle quiz end
          add(UpdateUserScore(userScore: _userScore, userId: 'user_id'));
        }
      }
    });
  }

  void _updateUserScore(UpdateUserScore event, Emitter<QuizState> emit) async {
    DocumentReference userRef = _firestore.collection('users').doc(event.userId);
    print("The user ref does not have any problem here");
    print(userRef);

    try {
      final snapshot = await userRef.get();

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);

        double currentHighScore = snapshot['highScore'];
        double weeklyScore = snapshot['weeklyScore'] ?? 0.0;
        double userPoints = snapshot['points']?? 0.0;
        int weeklyRank = snapshot['weeklyRank'] ?? 0;
        Timestamp lastUpdateTimestamp = snapshot['lastUpdateTimestamp'] ?? Timestamp.now();
        DateTime lastUpdateDate = lastUpdateTimestamp.toDate();
        DateTime now = DateTime.now();

        if (_isDifferentWeek(lastUpdateDate, now)) {
          // Reset weekly score if it's a new week
          weeklyScore = 0.0;
          weeklyRank = 0;

        }


        // Update weekly score if the current user score is higher
        if (event.userScore > weeklyScore) {
          weeklyScore = (event.userScore/state.questions.length)*100;
          //weeklyScore = event.userScore.toDouble();
        }


          _userPoints += userPoints;


        if (event.userScore > currentHighScore) {
          transaction.update(userRef, {'highScore': (event.userScore/state.questions.length)*100});
        }



        transaction.update(userRef, {
          'recentScore': (event.userScore/state.questions.length)*100,
          'weeklyScore': weeklyScore,
          'points': double.parse(_userPoints.toStringAsFixed(2)),
          'lastUpdateTimestamp': Timestamp.now(),
        });
      });

      // Save user progress points to Firestore
      await _saveUserProgress(event.userId, (event.userScore/state.questions.length)*100);


      print("No problem so far");

      emit(QuizSubmittedState(
        questions: state.questions,
        currentQuestionIndex: state.currentQuestionIndex,
        remainingTime: state.remainingTime,
        selectedAnswer: state.selectedAnswer,
        correctAnswer: state.correctAnswer,
        userAnswers: state.userAnswers,
      ));
      print('quiz submitted state has been emitted');
      print('The user points accumulated in the last quiz is $_userPoints');
      // Trigger the event to update weekly rank
      add(UpdateWeeklyRank(event.userId));
    } catch (e) {
      emit(QuizStateError('Failed to update user score: ${e.toString()}'));
    }
  }

  void _onUpdateWeeklyRank(UpdateWeeklyRank event, Emitter<QuizState> emit) async {
    try {
      final querySnapshot = await _firestore.collection('users').orderBy('weeklyScore', descending: true).get();
      final users = querySnapshot.docs;

      for (int i = 0; i < users.length; i++) {
        final userRef = users[i].reference;
        final weeklyRank = i + 1;
        await userRef.update({'weeklyRank': weeklyRank});
      }

      print("Weekly ranks updated successfully");
    } catch (e) {
      emit(QuizStateError('Failed to update weekly ranks: ${e.toString()}'));
    }
  }

  Future<void> _saveUserProgress(String userId, double userScore) async {
    final firestore = FirebaseFirestore.instance;
    final timestamp = Timestamp.now();
    final userScoresCollection = firestore.collection('user_scores').doc(userId).collection('scores');

    try {
      // Check if the collection already exists
      final existingCollection = await userScoresCollection.get();
      if (existingCollection.docs.isEmpty) {
        // Collection doesn't exist, create it
        await firestore.collection('user_scores').doc(userId).set({});
      }

      // Save user score
      await userScoresCollection.doc(timestamp.toString()).set({
        'userId': userId,
        'score': userScore,
        'timestamp': timestamp,
      });

      print('User score saved successfully');
    } catch (e) {
      print('Failed to save user score: ${e.toString()}');
    }
  }



  bool _isDifferentWeek(DateTime lastUpdateDate, DateTime now) {
    // Compare the year and week of the year to determine if it's a different week
    var lastUpdateWeek = _getWeekOfYear(lastUpdateDate);
    var currentWeek = _getWeekOfYear(now);
    return lastUpdateDate.year != now.year || lastUpdateWeek != currentWeek;
  }

  int _getWeekOfYear(DateTime date) {
    var firstDayOfYear = DateTime(date.year, 1, 1);
    var daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).ceil();
  }

  int get correctAnswersCount => _userScore;

  // Reset score after quiz completion
  void resetScore() {
    _userScore = 0;
  }


  void _onResetQuiz(ResetQuiz event, Emitter<QuizState> emit) {
    emit(const QuizState()); // Reset to initial state
    _userScore = 0;
    _timer?.cancel();
  }


  @override
  Future<void> close() {
    _timer?.cancel();
    // Reset the state to initial values
    emit(QuizState(questions: [], currentQuestionIndex: 0, remainingTime: 30, userAnswers: []));
    return super.close();
  }
}