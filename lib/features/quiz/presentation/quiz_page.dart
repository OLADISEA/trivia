import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/features/auth/presentation/widgets/submit_button.dart';
import 'package:trivia/features/quiz/data/quiz_repository.dart';
import 'package:trivia/features/quiz/presentation/quiz_result/quiz_result_page.dart';

import '../../../core/common/model/question.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class QuizPage extends StatefulWidget {
  final int amount;
  final String? category;
  final String? difficulty;
  final String? type;
  const QuizPage({super.key, required this.amount, this.category, this.difficulty, this.type});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  
  @override
  void initState() {
    context.read<QuizBloc>().add(LoadQuestions(
      amount: widget.amount,
      category: widget.category,
      difficulty: widget.difficulty,
      type: widget.type,
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              print(state.questions.length);
              return Text(
                  state.questions.isNotEmpty
                      ? 'Question ${state.currentQuestionIndex + 1}/${state.questions.length}'
                      : 'Loading Questions...'
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(left: 30.w, right: 20.w),
                  child: LinearProgressIndicator(
                    value: state.questions.isNotEmpty
                        ? (state.currentQuestionIndex + 1) / state.questions.length
                        : 0,
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state.questions.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final question = state.questions[state.currentQuestionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            question.question,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5.h,
                        left: 160.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60.w,
                              height: 60.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 4.w,
                                value: state.remainingTime / 30, // Assuming 30 seconds per question
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Text('${state.remainingTime}s'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: question.answers.length,
                      itemBuilder: (context, index) {
                        final answer = question.answers[index];
                        final isCorrectAnswer = answer == question.correctAnswer;
                        final isSelected = state.selectedAnswer == answer;
                        return Card(
                          color: isSelected
                              ? (isCorrectAnswer ? Colors.green : Colors.red)
                              : Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 140.w),
                            title: Text(answer),
                            onTap: () {
                              if (state.selectedAnswer == null) {
                                context.read<QuizBloc>().add(SelectAnswer(answer));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SubmitButton(
                      text: state.currentQuestionIndex < state.questions.length - 1 ? 'Next' : 'Submit',
                      color: Color(0XFF403C9A),
                      textColor: Colors.white,
                      onTap: () {
                        if (state.selectedAnswer != null) {
                          print('the selected anwer is ${state.selectedAnswer}');
                          if (state.currentQuestionIndex < state.questions.length - 1) {
                            context.read<QuizBloc>().add(NextQuestion());
                          } else {
                            // Submit the quiz and navigate to the next page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizResultPage(correctAnswersCount: quizBloc.correctAnswersCount, totalQuestions: quizBloc.state.questions.length),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      
    );
  }

  List<Question> fetchQuestions() {
    // Fetch and return questions from the trivia database
    return [
      Question(
        question: 'What is the capital of France?',
        answers: ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
        correctAnswer: 'Paris',
      ),
      Question(
        question: 'What is the capital of Oyo?',
        answers: ['Ibadan', 'Madrid', 'Paris', 'Lisbon'],
        correctAnswer: 'Ibadan',
      ),
      // Add more questions here
    ];
  }
}
