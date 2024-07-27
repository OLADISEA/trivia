import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_state.dart';

class QuizResultDetailPage extends StatelessWidget {
  const QuizResultDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizState = context.watch<QuizBloc>().state;

    final totalQuestions = quizState.questions.length;
    final correctAnswers = _getCorrectAnswersCount(quizState);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: $correctAnswers / $totalQuestions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: quizState.questions.length,
              itemBuilder: (context, index) {
                final question = quizState.questions[index];
                final selectedAnswer = quizState.userAnswers[index];
                final isCorrect = selectedAnswer == question.correctAnswer;

                return ListTile(
                  title: Text(question.question),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Answer: ${selectedAnswer ?? 'Not answered'}'),
                      Text('Correct Answer: ${question.correctAnswer}'),
                    ],
                  ),
                  trailing: Icon(
                    isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCorrectAnswersCount(QuizState quizState) {
    int correctAnswers = 0;
    for (int i = 0; i < quizState.questions.length; i++) {
      if (quizState.userAnswers[i] == quizState.questions[i].correctAnswer) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }
}











// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/quiz_bloc.dart';
//
// class QuizResultDetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final quizState = context.watch<QuizBloc>().state;
//
//     int totalQuestions = quizState.questions.length;
//     int correctAnswers = quizState.userAnswers.where((answer) => answer == quizState.correctAnswer).length;
//
//     List<Widget> buildQuestionItems() {
//       return quizState.questions.asMap().entries.map((entry) {
//         final index = entry.key;
//         final question = entry.value;
//         final selectedAnswer = quizState.userAnswers[index];
//         final isCorrect = selectedAnswer == question.correctAnswer;
//
//         return ListTile(
//           title: Text(question.question),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Your Answer: ${selectedAnswer ?? 'Not answered'}'),
//               Text('Correct Answer: ${question.correctAnswer}'),
//             ],
//           ),
//           trailing: Icon(
//             isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
//             color: isCorrect ? Colors.green : Colors.red,
//           ),
//         );
//       }).toList();
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz Result Detail'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Score: ${correctAnswers} / ${totalQuestions}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: buildQuestionItems(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
