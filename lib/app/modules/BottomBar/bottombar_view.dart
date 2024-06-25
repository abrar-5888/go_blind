import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_blind/app/modules/Home/home_view.dart';
import 'package:go_blind/app/modules/Profile/profile_view.dart';
import 'package:go_blind/config/theme/themeColors.dart';

class BottomBarPage extends StatelessWidget {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const <Widget>[
          // CallsPage(),
          HomePage(), ProfilePage()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        index: 0,
        buttonBackgroundColor: ThemeColors.seeGreen,
        color: ThemeColors.seeGreen,
        height: 65,
        items: const <Widget>[
          // Icon(
          //   Icons.call,
          //   size: 30,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        },
      ),
    );
  }
}
