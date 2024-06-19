import 'package:equatable/equatable.dart';

import '../../../core/common/model/question.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int remainingTime;
  final String? selectedAnswer; // Track user-selected answer
  final String? correctAnswer; // Track correct answer for current question
  final List<String?> userAnswers;

  QuizState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.remainingTime,
    this.selectedAnswer,
    this.correctAnswer,
    required this.userAnswers,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? remainingTime,
    String? selectedAnswer = _defaultString,
    String? correctAnswer = _defaultString,
    List<String?>? userAnswers
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      remainingTime: remainingTime ?? this.remainingTime,
      selectedAnswer: selectedAnswer == _defaultString ? this.selectedAnswer : selectedAnswer,
      correctAnswer: correctAnswer == _defaultString ? this.correctAnswer : correctAnswer,
      userAnswers: userAnswers ?? this.userAnswers,
    );
  }

  static const String _defaultString = '__DEFAULT__';

  @override
  List<Object?> get props => [questions, currentQuestionIndex, remainingTime, selectedAnswer, correctAnswer,userAnswers];
}

class QuizStateError extends QuizState {
  final String error;

  QuizStateError(this.error)
      : super(
    questions: [],
    currentQuestionIndex: 0,
    remainingTime: 30,
    selectedAnswer: null,
    correctAnswer: null,
    userAnswers: [],
  );

  @override
  QuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? remainingTime,
    String? selectedAnswer = QuizState._defaultString,
    String? correctAnswer = QuizState._defaultString,
    List<String?>? userAnswers,
    String? error,
  }) {
    return QuizStateError(
      error ?? this.error,
    );
  }
}
