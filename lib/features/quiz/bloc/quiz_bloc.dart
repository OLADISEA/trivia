import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/features/quiz/data/quiz_repository.dart';
import 'package:trivia/features/quiz/bloc/quiz_event.dart';
import 'package:trivia/features/quiz/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Timer? _timer;
  int _userScore = 0;

  QuizBloc({required this.quizRepository}) : super(const QuizState()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<SelectAnswer>(_onSelectAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<UpdateTimer>(_onUpdateTimer);
    on<UpdateUserScore>(_updateUserScore);
  }

  Future<void> _onLoadQuestions(LoadQuestions event, Emitter<QuizState> emit) async {
    try {
      // Reset score and timer when loading new questions
      resetScore();
      _timer?.cancel();

      final questions = await quizRepository.fetchQuestions(
        amount: event.amount,
        category: event.category,
        difficulty: event.difficulty,
        type: event.type,
        encoding: event.encoding,
      );

      // Initialize userAnswers with the correct length and null values
      final newUserAnswers = List<String?>.filled(questions.length, null);

      print("The bloc state has the set of questions");
      print(questions.length);
      final newState = state.copyWith(questions: questions, userAnswers: newUserAnswers);
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

    emit(state.copyWith(
      selectedAnswer: event.answer,
      correctAnswer: isCorrect ? event.answer : state.questions[state.currentQuestionIndex].correctAnswer,
      userAnswers: newUserAnswers,
    ));
    _userScore = updatedScore;
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
          add(UpdateUserScore(userScore: _userScore, userId: 'user_id')); // Add userId as required
        }
      }
    });
  }

  void _updateUserScore(UpdateUserScore event, Emitter<QuizState> emit) async {
    //emit(QuizLoadingState());
    print(event.userId);
    print('this is the user id ${event.userId}');
    DocumentReference userRef = _firestore.collection('users').doc(event.userId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userRef);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      int currentHighScore = snapshot['highScore'];

      if (event.userScore > currentHighScore) {
        transaction.update(userRef, {'highScore': event.userScore});
      }
    });
    print('the state.question length is ${state.questions}');

    emit(QuizSubmittedState(
      questions: state.questions,
      currentQuestionIndex: state.currentQuestionIndex,
      remainingTime: state.remainingTime,
      selectedAnswer: state.selectedAnswer,
      correctAnswer: state.correctAnswer,
      userAnswers: state.userAnswers,
    ));
  }

  int get correctAnswersCount => _userScore;

  // Reset score after quiz completion
  void resetScore() {
    _userScore = 0;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    // Reset the state to initial values
    emit(QuizState(questions: [], currentQuestionIndex: 0, remainingTime: 30, userAnswers: []));
    return super.close();
  }
}
