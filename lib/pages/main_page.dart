import 'package:flutter/material.dart';
import 'package:mooc_app/pages/SubPages/main_page.dart';
import 'package:mooc_app/pages/SubPages/user_profile.dart';
import 'package:mooc_app/pages/SubPages/video_detail.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final screens = [
    HomePage(),
    UserProfile(),
    VideoDetail(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_call),
              label: 'Video',
            ),
          ]),
    );
  }
}
