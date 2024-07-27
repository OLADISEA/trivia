import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trivia/core/quiz/screens/quiz_result_page.dart';
import '../../data/shared_preference_helper.dart';
import '../../widgets/flutter_toast.dart';
import '../auth/widgets/submit_button.dart';
import 'bloc/quiz_bloc.dart';
import 'bloc/quiz_event.dart';
import 'bloc/quiz_state.dart';

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

  String? userId;
  
  @override
  void initState() {
    super.initState();
    getUserId();
    context.read<QuizBloc>().add(ResetQuiz());
    context.read<QuizBloc>().add(LoadQuestions(
      amount: widget.amount,
      category: widget.category,
      difficulty: widget.difficulty,
      type: widget.type,
    ));
  }

  Future<void> getUserId()async{
    String? userId = await SharedPreferencesHelper().getUserId();
    setState(() {
       this.userId = userId;
    });
    print('the user id in the quiz page is $userId');

  }

  @override
  void dispose() {
    //context.read<QuizBloc>().add(ResetQuiz());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizBloc = BlocProvider.of<QuizBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              //print(state.questions.length);
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
                  height: 10.h,
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
          child: BlocConsumer<QuizBloc, QuizState>(
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
                      //SizedBox(height: 50.h,),
                      Container(
                        margin: EdgeInsets.only(top: 85.h),
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Color(0XFFdcf8ff),
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
                        top: 60.h,
                        left: 160.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 45.w,
                              height: 45.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 10.w,
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
                  //SizedBox(height: 50.h),
                  Container(
                    margin: EdgeInsets.only(left: 25,top: 50),
                    //alignment: Alignment.bottomCenter,
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
                            print(userId);
                            // Submit the quiz and navigate to the next page
                            context.read<QuizBloc>().add(UpdateUserScore(userScore: quizBloc.correctAnswersCount,userId: userId!));

                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }, listener: (BuildContext context, QuizState state) {
              if(state is QuizSubmittedState){
                print('the questions in the state is ${state.questions.length}');
                print("I am in the listener state");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizResultPage(correctAnswersCount: quizBloc.correctAnswersCount, totalQuestions: quizBloc.state.questions.length),
                  ),
                );
              }
              if(state is QuizStateError){
                toastInfo(msg: state.error);
                Navigator.pop(context);
              }
          },
          ),
        ),
      
    );
  }

}
