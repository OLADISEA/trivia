import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/shared_preference_helper.dart';
import '../../widgets/back_arrow.dart';
import '../../widgets/reusable_text.dart';
import '../../widgets/submit_button.dart';
import '../auth/widgets/textfield.dart';
import 'bloc/theme_bloc/theme_bloc.dart';
import 'bloc/theme_bloc/theme_event.dart';
import 'bloc/theme_bloc/theme_mode.dart';
import 'bloc/theme_bloc/theme_state.dart';
import 'bloc/user_image_bloc/image_bloc.dart';
import 'bloc/user_image_bloc/image_event.dart';


class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String? userId;
  String? userImageUrl;
  String? username;
  String? userEmail;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    _loadUserData();

  }


  Future<void> _loadUserData() async {
    try {
      String? userId = await _sharedPreferencesHelper.getUserId();
      String? username = await _sharedPreferencesHelper.getUserName();
      String? userEmail = await _sharedPreferencesHelper.getUserEmail();
      String? userImageUrl = await _sharedPreferencesHelper.getUserImageUrl();

      setState(() {
        this.userId = userId;
        this.username = username;
        this.userEmail = userEmail;
        this.userImageUrl = userImageUrl;
      });
    } catch (e) {
      // Handle error here
      print("Failed to load user data: $e");
    }
  }



  Future<void> _pickImage(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null && userId != null) {
        context.read<ImageBloc>().add(UploadImageEvent(userId!, pickedFile.path));
      }
    } catch (e) {
      // Handle error here
      print("Failed to pick image: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25.w, top: 60.h,right: 25.w),
        child: Column(
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (BuildContext context, state) {
                return Container(
                  //margin: EdgeInsets.only(left: 10.w,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BackArrow(),
                      SizedBox(width: 85.w,),
                      Reusable(text: "Edit Profile",fontSize: 20.sp,fontWeight: FontWeight.w900,),
                      SizedBox(width: 50.w,),

                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 30.h,),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: userImageUrl != null
                      ? NetworkImage(userImageUrl!)
                      : const AssetImage("assets/images/user-image.png") as ImageProvider<Object>,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _pickImage(context),
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 15.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Column(
              children: [
                username == null
                    ? const CircularProgressIndicator()
                    : Reusable(text: username!, fontSize: 18.sp,fontWeight: FontWeight.w900,),
                userEmail == null
                    ? const CircularProgressIndicator()
                    : Reusable(text: userEmail!, fontSize: 16.sp),

              ],
            ),
            Row(
              children: [
                const Icon(Icons.person),
                SizedBox(width: 5.w,),
                const Reusable(text: "Name")
              ],
            ),
            SizedBox(height: 5.h,),
            AuthTextField(controller: nameController, text: "Edit your name"),

            SizedBox(height: 15.h,),
            Row(
              children: [
                const Icon(Icons.email),
                SizedBox(width: 5.w,),
                const Reusable(text: "Email")
              ],
            ),
            SizedBox(height: 5.h,),
            AuthTextField(controller: emailController, text: "Edit your name"),

            SizedBox(height: 35.h,),
            SubmitButton(
              width: 350.w,
              text: "Update Profile",
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),

            Container(
              margin: EdgeInsets.only(left: 100.w,top: 20.h),
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (BuildContext context, state) {
                  return Row(
                    children: [
                      Reusable(text: "Dark Mode", fontSize: 20.sp,),
                      SizedBox(width: 5.w,),
                      CupertinoSwitch(
                        value: state.status == AppThemeMode.dark,
                        onChanged: (value) {
                          context.read<ThemeBloc>().add(ToggleThemeEvent());
                        },
                      ),

                    ],
                  );
                }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
