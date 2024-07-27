import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/user_score.dart';
import '../../widgets/reusable_text.dart';
import 'bloc/ranking_bloc.dart';
import 'bloc/ranking_event.dart';
import 'bloc/ranking_state.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {

  void initState(){
    super.initState();
    context.read<RankingBloc>().add(FetchUserRankings(userId: 'userId'));

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF), // Background color set to white
        body: BlocBuilder<RankingBloc, RankingState>(
          builder: (context, state) {
            if (state is RankingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RankingLoaded) {
              return _buildRankingList(state.userScores);
            } else if (state is RankingError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildRankingList(List<UserScore> userScores) {
    if (userScores.isEmpty) {
      return const Center(child: Text('No data available'));
    } else if (userScores.length > 3) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            //SizedBox(height: 180.h,),
            ClipPath(
              clipper: BottomCircularClipper(),
              child: Container(
                height: 1000.h,
                color: const Color(0XFF3cb6d2),
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    Row(
                      children: [
                        SizedBox(width: 30.w,),
                        const Icon(Icons.arrow_back_ios,color: Colors.white,),
                        SizedBox(width: 120.w,),
                        Reusable(text: "Leaderboard", textColor: Colors.white,fontSize: 18.sp,)

                      ],
                    ),
                  ],
                ),// Container color set to blue
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 350.h), // Adjust the padding to your needs
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                shrinkWrap: true, // Use shrinkWrap to make ListView work inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemCount: userScores.length-3,
                itemBuilder: (context, index) {
                  final userScore = userScores[index+3];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                      leading: Reusable(text: '${index + 4}', fontSize: 12.sp,), // Rank number
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: userScore.imageUrl != null && userScore.imageUrl.isNotEmpty
                                ? NetworkImage(userScore.imageUrl)
                                : AssetImage("assets/images/user-image.png") as ImageProvider,
                          ),
                          SizedBox(width: 10.w,),
                          Reusable(text: userScore.userName),
                        ],
                      ),
                      trailing: Reusable(
                        text: userScore.highScore.toString(),
                        textColor: Colors.lightBlue,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 721.h,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBottomContainer(
                      height: 120.h,
                      width: 100.w,
                      imageSize: 50.w,
                      rank: 2,
                      name: userScores[1].userName,
                      score: userScores[1].highScore,
                      imageUrl: userScores[1].imageUrl,
                  ),
                  _buildBottomContainer(
                      height: 150.h,
                      width: 120.w,
                      imageSize: 80.w,
                      rank: 1,
                      name: userScores[0].userName,
                      score: userScores[0].highScore,
                      imageUrl: userScores[0].imageUrl,
                  ),
                  _buildBottomContainer(
                      height: 120.h,
                      width: 100.w,
                      imageSize: 50.w,
                      rank: 3,
                      name: userScores[2].userName,
                      score: userScores[2].highScore,
                      imageUrl: userScores[2].imageUrl,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: userScores.length,
      itemBuilder: (context, index) {
        final userScore = userScores[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 23.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          child: ListTile(
            leading: Text('${index + 1}'), // Rank number
            title: Text(userScore.userName),
            trailing: Reusable(
              text: 'Score: ${userScore.highScore}',
              textColor: Colors.lightBlue,
            ),
          ),
        );
      },
    );
  }
}

Widget _buildBottomContainer({
  required double height,
  required double width,
  required double imageSize,
  required int rank,
  required String name,
  required double score,
  required String? imageUrl,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Color(0xff4bbad4),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r)
        )
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -18.h,
          left: 20.w,
          child: ClipRRect(
            child: Stack(
              children: [
                SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child:  CircleAvatar(
                    radius: imageSize / 2,
                    backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : AssetImage("assets/images/user-image.png") as ImageProvider,
                  ),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 10.r,
                    child: Reusable(
                      text: rank.toString(),
                      fontSize: 8.sp,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.h,),
              Reusable(text: name, fontSize: 15.sp, textColor: Colors.white),
              SizedBox(height: 8.h), // Adjust spacing between texts
              Reusable(text: score.toString(), fontSize: 12.sp, textColor: Colors.white),
            ],
          ),
        ),
      ],
    ),
  );
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomCircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 1.9);
    path.arcToPoint(
      Offset(size.width, size.height * 0.3),
      radius: Radius.circular(size.height * 0.2),
      clockwise: true,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}












// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trivia/core/common/widgets/reusable_text.dart';
//
// import '../../../core/common/model/user_score.dart';
// import '../bloc/ranking_bloc.dart';
// import '../bloc/ranking_event.dart';
// import '../bloc/ranking_state.dart';
//
// class RankingPage extends StatelessWidget {
//   const RankingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final rankingBloc = context.read<RankingBloc>();
//     rankingBloc.add(FetchUserRankings(userId: ''));
//
//     return Scaffold(
//       backgroundColor: const Color(0XFF49b8d1),
//       appBar: AppBar(
//         title: const Center(child: Text('Leaderboard')),
//       ),
//       body: BlocBuilder<RankingBloc, RankingState>(
//         builder: (context, state) {
//           if (state is RankingLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is RankingLoaded) {
//             return _buildRankingList(state.userScores);
//           } else if (state is RankingError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text('Unknown state'));
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildRankingList(List<UserScore> userScores) {
//     if (userScores.isEmpty) {
//       return const Center(child: Text('No data available'));
//     } else if (userScores.length > 3) {
//       return Column(
//         children: [
//           ClipPath(
//             clipper: TopCircularClipper(),
//             child: Container(
//               margin: EdgeInsets.only(top: 100.h),
//               height: 600.h,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0XFFFFFFFF),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20),
//                   topLeft: Radius.circular(20),
//                 ),
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.only(top: 80.h),
//                 itemCount: userScores.length,
//                 itemBuilder: (context, index) {
//                   final userScore = userScores[index];
//                   return Container(
//                     margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 23.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.r),
//                       border: Border.all(
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                     ),
//                     child: ListTile(
//                       leading: Reusable(text: '${index + 1}',fontSize: 12.sp,), // Rank number
//                       title: Row(
//                         children: [
//                           Image.asset("assets/images/user-image.png"),
//                           SizedBox(width: 10.w,),
//                           Reusable(text: userScore.userName),
//                         ],
//                       ),
//                       trailing: Reusable(
//                         text: userScore.highScore.toString(),
//                         textColor: Colors.lightBlue,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//
//     return ListView.builder(
//       itemCount: userScores.length,
//       itemBuilder: (context, index) {
//         final userScore = userScores[index];
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 23.w),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.r),
//             border: Border.all(
//               color: Colors.grey.withOpacity(0.5),
//             ),
//           ),
//           child: ListTile(
//             leading: Text('${index + 1}'), // Rank number
//             title: Text(userScore.userName),
//             trailing: Reusable(
//               text: 'Score: ${userScore.highScore}',
//               textColor: Colors.lightBlue,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class TopCircularClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(0, size.height * 0.9);
//     path.arcToPoint(
//       Offset(size.width, size.height * 0.246),
//       radius: Radius.circular(size.height * 0.1),
//     );
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
