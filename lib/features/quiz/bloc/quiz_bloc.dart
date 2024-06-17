import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/features/quiz/data/quiz_repository.dart';
import 'package:trivia/features/quiz/bloc/quiz_event.dart';
import 'package:trivia/features/quiz/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  Timer? _timer;

  QuizBloc({required this.quizRepository}) : super(QuizState(questions: [], currentQuestionIndex: 0, remainingTime: 30)) {
    on<LoadQuestions>(_onLoadQuestions);
    on<SelectAnswer>(_onSelectAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<UpdateTimer>(_onUpdateTimer);
    _startTimer();
  }

  void _onLoadQuestions(LoadQuestions event, Emitter<QuizState> emit) async {
    try {
      final questions = await quizRepository.fetchQuestions(
        amount: event.amount,
        category: event.category,
        difficulty: event.difficulty,
        type: event.type,
        encoding: event.encoding,
      );
      emit(state.copyWith(questions: questions));
    } catch (e) {
      emit(QuizStateError(e.toString()));
    }
  }

  void _onSelectAnswer(SelectAnswer event, Emitter<QuizState> emit) {
    final isCorrect = event.answer == state.questions[state.currentQuestionIndex].correctAnswer;
    emit(state.copyWith(
      selectedAnswer: event.answer,
      correctAnswer: isCorrect ? event.answer : state.questions[state.currentQuestionIndex].correctAnswer,
    ));
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedAnswer: null,
        correctAnswer: null,
        remainingTime: 30,
      ));
    }
  }

  void _onUpdateTimer(UpdateTimer event, Emitter<QuizState> emit) {
    emit(state.copyWith(remainingTime: event.remainingTime));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        add(UpdateTimer(state.remainingTime - 1));
      } else {
        if (state.currentQuestionIndex < state.questions.length - 1) {
          add(NextQuestion());
        } else {
          timer.cancel();
          // Handle quiz end
        }
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
