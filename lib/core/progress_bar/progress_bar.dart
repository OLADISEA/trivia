import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../data/shared_preference_helper.dart';
import 'bloc/progress_bloc.dart';
import 'bloc/progress_event.dart';
import 'bloc/progress_state.dart';

class LineTiles {
  static getTilesData() => FlTitlesData(show: true);
}

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    // Assume getUserId() fetches the user ID from shared preferences or another source
    userId = await SharedPreferencesHelper().getUserId(); // Replace with actual logic to get userId
    print(userId);
    if (userId != null) {
      if(context.mounted) {
        context.read<ProgressBloc>().add(FetchProgress(userId!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
            if (state is ProgressLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProgressLoaded) {
              if (state.progress.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 420.h,),
                    Center(
                      child: Text(
                        'No progress data available. Keep partaking in quizzes!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                );
              }

              final progressPoints = state.progress
                  .map((data) => FlSpot(
                data['x'].toDouble(), // Use 'x' as the x-axis value
                data['score'].toDouble(),
              ))
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h,),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      //'All Time Performance Bar \u{1F525}\u{1F525}\u{1F525}',
                      'All Time Performance Bar \u{1F970}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: state.progress.last['score'].toInt(),
                            size: 15,
                            padding: 0,
                            selectedColor: Colors.yellow,
                            unselectedColor: Colors.cyan,
                            roundedEdges: const Radius.circular(8.0),
                            selectedGradientColor: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.orange, Colors.red]),
                            unselectedGradientColor: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, Colors.blue],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${state.progress.last['score']}%',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 90.h,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Performance per Quiz Attempt',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                      //color: Color(0xff2d6cdf),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Center(
                      child: LineChart(
                        LineChartData(
                          minX: 1,
                          maxX: progressPoints.length <7 ?progressPoints.length.toDouble():7.toDouble(),
                          minY: 0,
                          maxY: 100,
                          titlesData: LineTiles.getTilesData(),
                          backgroundColor: Theme.of(context).canvasColor,
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.blue),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                                isCurved: true,
                                gradient: const LinearGradient(
                                    colors: [Colors.lightBlue, Colors.blue]),
                                barWidth: 5,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                      colors: <Color>[Colors.lightBlue, Colors.blue]
                                          .map((color) => color.withOpacity(0.3))
                                          .toList()),
                                ),
                                spots: progressPoints
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            } else if (state is ProgressError) {
              return Center(child: Text(state.message));
            } else {
              return Center(
                child: Text(
                  'No progress data available. Keep partaking in quizzes!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import '../bloc/progress_bloc.dart';
// import '../bloc/progress_event.dart';
// import '../bloc/progress_state.dart';
//
// class LineTiles {
//   static getTilesData() => FlTitlesData(show: true);
// }
//
// class ProgressPage extends StatefulWidget {
//   const ProgressPage({Key? key}) : super(key: key);
//
//   @override
//   State<ProgressPage> createState() => _ProgressPageState();
// }
//
// class _ProgressPageState extends State<ProgressPage> {
//   String? userId;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserId();
//   }
//
//   Future<void> getUserId() async {
//     // Assume getUserId() fetches the user ID from shared preferences or another source
//     userId = 'sampleUserId'; // Replace with actual logic to get userId
//     if (userId != null) {
//       context.read<ProgressBloc>().add(FetchProgress(userId!));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'App Name',
//           style: Theme.of(context).textTheme.headline5,
//         ),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: BlocBuilder<ProgressBloc, ProgressState>(
//           builder: (context, state) {
//             if (state is ProgressLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProgressLoaded) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                     height: MediaQuery.of(context).size.height * 0.25,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                       border: Theme.of(context).brightness == Brightness.dark
//                           ? Border.all(color: Colors.white)
//                           : null,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(left: 8.0),
//                           width: MediaQuery.of(context).size.width * 0.35,
//                           child: Align(child: Image.asset('assets/images/progress_img.png')),
//                         ),
//                         Flexible(
//                           child: SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.55,
//                             child: Align(
//                               child: RichText(
//                                 text: TextSpan(
//                                     text: 'Play & Win.\n',
//                                     style: TextStyle(
//                                       fontFamily: GoogleFonts.caveatBrush().fontFamily,
//                                       fontSize: 30,
//                                     ),
//                                     children: [
//                                       const TextSpan(text: ''),
//                                       TextSpan(text: 'Progress: ${state.progress}%'),
//                                     ]),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'All Time Performance Bar \u{1F525}\u{1F525}\u{1F525}',
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: StepProgressIndicator(
//                             totalSteps: 100,
//                             currentStep: state.progress,
//                             size: 15,
//                             padding: 0,
//                             selectedColor: Colors.yellow,
//                             unselectedColor: Colors.cyan,
//                             roundedEdges: const Radius.circular(8.0),
//                             selectedGradientColor: const LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: [Colors.orange, Colors.red]),
//                             unselectedGradientColor: const LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [Colors.black, Colors.blue],
//                             ),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             '\u{1F929}',
//                             style: TextStyle(fontSize: 25),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Performance per Quiz Attempt \u{1f4ca}',
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(16.0),
//                     height: MediaQuery.of(context).size.height * 0.25,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                     ),
//                     child: Center(
//                       child: LineChart(
//                         LineChartData(
//                           minX: 1,
//                           maxX: 7,
//                           minY: 0,
//                           maxY: 100,
//                           titlesData: LineTiles.getTilesData(),
//                           backgroundColor: Theme.of(context).canvasColor,
//                           borderData: FlBorderData(
//                             show: true,
//                             border: Border.all(color: Colors.blue),
//                           ),
//                           lineBarsData: [
//                             LineChartBarData(
//                                 isCurved: true,
//                                 gradient: const LinearGradient(
//                                     colors: [Colors.lightBlue, Colors.blue]),
//                                 barWidth: 5,
//                                 dotData: FlDotData(show: false),
//                                 belowBarData: BarAreaData(
//                                   show: true,
//                                   gradient: LinearGradient(
//                                       colors: <Color>[Colors.lightBlue, Colors.blue]
//                                           .map((color) => color.withOpacity(0.3))
//                                           .toList()),
//                                 ),
//                                 spots: [
//                                   FlSpot(1, state.progress * 0.1),
//                                   FlSpot(2, state.progress * 0.2),
//                                   FlSpot(3, state.progress * 0.3),
//                                   FlSpot(4, state.progress * 0.4),
//                                   FlSpot(5, state.progress * 0.5),
//                                   FlSpot(6, state.progress * 0.6),
//                                   FlSpot(7, state.progress * 0.7),
//                                 ]),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Past 10 Attempts',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.headline5,
//                           ),
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor: Colors.lightBlue,
//                           ),
//                           onPressed: () {
//                             // Implement navigation to view all history
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'View All',
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText2!
//                                   .copyWith(fontSize: 12, color: Colors.blue),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 100,
//                     child: Center(
//                       child: Text(
//                         'No items yet',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText2!
//                             .copyWith(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(16.0),
//                     height: MediaQuery.of(context).size.height * 0.25,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                       border: Theme.of(context).brightness == Brightness.dark
//                           ? Border.all(color: Colors.white)
//                           : null,
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: Text(
//                           '"A man\'s mind, stretched by new ideas, may never return to its original dimensions." - Oliver Wendell Holmes Jr.',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is ProgressError) {
//               return Center(child: Text(state.message));
//             } else {
//               return Center(child: Text('No data available.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
// // // progress_page.dart
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../auth/data/shared_preference_helper.dart';
// // import '../bloc/progress_bloc.dart';
// // import '../bloc/progress_event.dart';
// // import '../bloc/progress_state.dart';
// //
// // class ProgressPage extends StatefulWidget {
// //   const ProgressPage({super.key});
// //
// //   @override
// //   State<ProgressPage> createState() => _ProgressPageState();
// // }
// //
// // class _ProgressPageState extends State<ProgressPage> {
// //   String? userId;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getUserId();
// //   }
// //
// //   Future<void> getUserId() async {
// //     // Assume getUserId() fetches the user ID from shared preferences or another source
// //     userId = await SharedPreferencesHelper().getUserId();
// //     if (userId != null) {
// //       context.read<ProgressBloc>().add(FetchUserProgress(userId!));
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('User Progress'),
// //       ),
// //       body: BlocBuilder<ProgressBloc, ProgressState>(
// //         builder: (context, state) {
// //           if (state is ProgressLoading) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (state is ProgressLoaded) {
// //             return _buildProgressChart(state.progressPoints);
// //           } else if (state is ProgressError) {
// //             return Center(child: Text(state.message));
// //           } else {
// //             return Center(child: Text('No data available'));
// //           }
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProgressChart(List<FlSpot> progressPoints) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: LineChart(
// //         LineChartData(
// //           gridData: FlGridData(show: true),
// //           titlesData: FlTitlesData(show: true),
// //           borderData: FlBorderData(show: true),
// //           minX: 0,
// //           maxX: 10,
// //           minY: 0,
// //           maxY: 10,
// //           lineBarsData: [
// //             LineChartBarData(
// //               spots: progressPoints,
// //               isCurved: true,
// //               barWidth: 4,
// //               belowBarData:
// //               BarAreaData(
// //                   show: true,
// //                   ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
