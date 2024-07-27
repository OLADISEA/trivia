import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/shared_preference_helper.dart';
import '../../../widgets/back_arrow.dart';
import '../../../widgets/reusable_text.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/pages/login_page.dart';
import '../../settings/bloc/user_image_bloc/image_bloc.dart';
import '../../settings/bloc/user_image_bloc/image_event.dart';
import '../../settings/settings.dart';
import '../bloc/user_stats_bloc.dart';
import '../bloc/user_stats_event.dart';
import '../bloc/user_stats_state.dart';
import '../widgets/game_stats.dart';
import '../widgets/user_ranking.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? userId;
  String? userEmail;
  String? userImageUrl;

  @override
  void initState() {
    super.initState();
    getUserId();
    getUsername();
    getUserEmail();
    getUserImageUrl();
  }

  Future<void> getUserId() async {
    String? userId = await SharedPreferencesHelper().getUserId();
    setState(() {
      this.userId = userId;
    });
    if (userId != null) {
      context.read<UserStatsBloc>().add(FetchUserStats(userId));
    }
  }

  Future<void> getUsername() async {
    String? username = await SharedPreferencesHelper().getUserName();
    setState(() {
      this.username = username;
    });
  }

  Future<void> getUserEmail() async {
    String? userEmail = await SharedPreferencesHelper().getUserEmail();
    setState(() {
      this.userEmail = userEmail;
    });
  }

  Future<void> getUserImageUrl() async {
    String? imageUrl = await SharedPreferencesHelper().getUserImageUrl();
    setState(() {
      userImageUrl = imageUrl;
    });
    if(userImageUrl != null){
      print("this is not null");
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && userId != null) {
      context.read<ImageBloc>().add(UploadImageEvent(userId!, pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 31.h, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const BackArrow(),
                  SizedBox(width: 100.w,),
                  Reusable(text: "Profile", fontSize: 25.sp,fontWeight: FontWeight.w800,),
                ],
              ),
              SizedBox(height: 20.h),


                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: userImageUrl != null
                        ? NetworkImage(userImageUrl!)
                        : const AssetImage("assets/images/user-image.png") as ImageProvider<Object>,
                  ),

              BlocBuilder<UserStatsBloc, UserStatsState>(
                builder: (context, state) {
                  if (state is UserStatsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserStatsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is UserStatsLoaded) {
                    final stats = state.stats;
                    return Column(
                      children: [


                        username == null
                            ? const CircularProgressIndicator()
                            : Reusable(text: username!, fontSize: 18.sp,fontWeight: FontWeight.w800,),
                        userEmail == null
                            ? const CircularProgressIndicator()
                            : Reusable(text: userEmail!, fontSize: 16.sp),
                        SizedBox(height: 18.h),
                        const UserRanking(),
                        SizedBox(height: 10.h),
                        GameStats(statTitle: "Last game score", playerStat: stats.lastGameScore.toString()),
                        SizedBox(height: 15.h),
                        GameStats(statTitle: "Weekly Score", playerStat: stats.weeklyScore.toString()),
                        SizedBox(height: 15.h),
                        GameStats(statTitle: "Weekly Rank", playerStat: stats.weeklyRank.toString()),
                        SizedBox(height: 15.h),
                        GameStats(statTitle: "Monthly score", playerStat: stats.monthlyScore.toString()),
                        SizedBox(height: 15.h),
                        GameStats(statTitle: "Monthly Rank", playerStat: stats.monthlyRank.toString()),
                        SizedBox(height: 30.h,),
                        _userActions(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
                          },
                        ),
                        SizedBox(height: 15.h),
                        BlocListener<AuthBloc, AuthState>(
                          child: _userActions(
                            icon: Icons.logout_outlined,
                            title: 'Logout',
                            onTap: () {
                              context.read<AuthBloc>().add(LogoutRequested());
                            },
                          ),
                          listener: (BuildContext context, AuthState state) {
                            if (state is AuthUnauthenticated) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                            }
                          },
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userActions({required IconData icon, required String title, required Function() onTap}) {
    return Container(
      padding: EdgeInsets.only(top: 5.h),
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.4)
        )
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Reusable(text: title,fontSize: 16.sp,),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
