abstract class QuizEvent {}

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
