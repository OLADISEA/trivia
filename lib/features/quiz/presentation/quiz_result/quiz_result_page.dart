import 'package:flutter/material.dart';
import 'package:trivia/core/common/model/question.dart';
import 'package:trivia/features/quiz/presentation/quiz_result/quiz_details_page.dart';

class QuizResultPage extends StatelessWidget {
  final int correctAnswersCount;
  final int totalQuestions;

  QuizResultPage({required this.correctAnswersCount, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$correctAnswersCount / $totalQuestions',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to detailed result view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizResultDetailPage(),
                  ),
                );
              },
              child: Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
