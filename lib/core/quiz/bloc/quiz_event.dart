import 'package:equatable/equatable.dart';

sealed class QuizEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuestions extends QuizEvent {
  final int amount;
  final String? category;
  final String? difficulty;
  final String? type;
  final String? encoding;

  LoadQuestions({
    this.amount = 10,
    this.category,
    this.difficulty,
    this.type,
    this.encoding,
  });
}

class SelectAnswer extends QuizEvent {
  final String answer;

  SelectAnswer(this.answer);
}

class NextQuestion extends QuizEvent {}

class UpdateTimer extends QuizEvent {
  final int remainingTime;

  UpdateTimer(this.remainingTime);
}

class UpdateUserScore extends QuizEvent{
  final int userScore;
  final String userId;

  UpdateUserScore({required this.userScore,required this.userId});
}


class UpdateWeeklyRank extends QuizEvent {
  final String userId;

  UpdateWeeklyRank(this.userId);

}



class ResetQuiz extends QuizEvent {}