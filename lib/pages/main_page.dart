import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/SubPages/Courses/courses_page.dart';
import 'package:mooc_app/pages/SubPages/Home/home_page.dart';
import 'package:mooc_app/pages/SubPages/UserProfile/user_profile.dart';
import 'package:mooc_app/pages/SubPages/video_detail.dart';

class MainPage extends StatefulWidget {
  final User user;
  MainPage({Key? key, required this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(user);
}

class _MainPageState extends State<MainPage> {
  User user;
  int currentIndex = 0;
  _MainPageState(this.user); //constructor
  screens(user) {
    return ([
      HomePage(),
      UserProfile(),
      CoursesPage(user: user),
    ]);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late User currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(user);
    final pageContent = Scaffold(
      body: screens(user)[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Course',
            ),
          ]),
    );

    return pageContent;
  }
}
