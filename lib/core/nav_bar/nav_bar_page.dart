import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/pages/home_page.dart';
import '../home/pages/profile_page.dart';
import '../progress_bar/progress_bar.dart';
import '../ranking/leader_board.dart';
import '../ranking/ranking_page.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context)=> NavBarPage());
  }

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    LeaderBoardPage(),
    ProgressPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -2), // Offset for shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/home-icon.png",width: 20.w),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/leaderboard-icon.png",width: 20.w,),
                //size: 30.sp, // Adjust the size here
              //backgroundColor: Colors.transparent,
              label: 'Leaders Board',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/progress-chart.png',width: 20.w,color: Colors.black,),
              label: 'Progress Chart',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/profile-icon.png",width: 20.w,color: Colors.black,),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
