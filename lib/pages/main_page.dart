//Bottom Navigation Bar
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/SubPages/Courses/courses_page.dart';
import 'package:mooc_app/pages/SubPages/Home/home_page.dart';
import 'package:mooc_app/pages/SubPages/UserProfile/user_profile.dart';

class MainPage extends StatefulWidget {
  final User user;
  MainPage({Key? key, required this.user}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(user);
}

class _MainPageState extends State<MainPage> {
  User user;
  int currentIndex = 0;
  _MainPageState(this.user);
  //constructor
  screens(user) {
    return ([
      //Different Profiles
      HomePage(user: user),
      UserProfile(user: user),
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
            ), // Icon
            label: 'Home',
          ), //BottomNavigationBarItem
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ), // Icon
            label: 'Profile',
          ), // BottomNavigationBarItem
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Courses',
          ), // BottomNavigationBarItem
        ], // <BottomNavigationBarItem>[]
      ), // BottomNavigationBar
    ); // Scafflod

    return pageContent;
    //Returning the pageContent
  }
}
