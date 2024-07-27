class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    // Combine correct_answer and incorrect_answers into a single list
    List<String> answers = List<String>.from(json['incorrect_answers']);
    answers.add(json['correct_answer']);
    answers.shuffle();  // Shuffle to randomize the order

    return Question(
      question: json['question'],
      answers: answers,
      correctAnswer: json['correct_answer'],
    );
  }
}
