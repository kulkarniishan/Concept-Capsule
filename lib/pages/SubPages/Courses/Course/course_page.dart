import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Forum/forum_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Grades/grades_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Overview/overview_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Resources/resources_page.dart';

class CoursePage extends StatefulWidget {
  final String courseId;
  final User user;
  CoursePage({Key? key, required this.courseId, required this.user})
      : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState(this.courseId, this.user);
}

class _CoursePageState extends State<CoursePage> {
  int currentIndex = 0;
  String courseId;
  User user;

  _CoursePageState(this.courseId, this.user);

  subpages(course, user) {
    return ([
      OverviewPage(course: course, user: user),
      GradesPage(),
      ForumPage(),
      ResourcesPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // print(courseId);
    final DocumentReference course =
        FirebaseFirestore.instance.collection('course').doc(courseId);
    return FutureBuilder(
      future: course.get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // print(snapshot.data!['name']);
            final DocumentSnapshot course = snapshot.data!;
            // print(snapshot.data?.toString());
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  course['title'],
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Image.network(
                      course['coverImage'],
                      height: 250,
                    ),
                    GNav(
                      rippleColor: (Colors
                          .grey[800])!, // tab button ripple color when pressed
                      hoverColor: (Colors.grey[700])!, // tab button hover color
                      haptic: true, // haptic feedback
                      tabBorderRadius: 15,
                      duration:
                          Duration(milliseconds: 400), // tab animation duration
                      gap: 8, // the tab button gap between icon and text
                      color: Colors.grey[800], // unselected icon color
                      activeColor: Colors.blue, // selected icon and text color
                      iconSize: 24, // tab button icon size
                      tabBackgroundColor: Colors.blue
                          .withOpacity(0.2), // selected tab background color
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      tabMargin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      selectedIndex: currentIndex,
                      onTabChange: (index) {
                        setState(() {
                          currentIndex = index;
                          // print(index);
                        });
                      },
                      tabs: [
                        GButton(
                          icon: Icons.library_books_outlined,
                          text: 'Overview',
                        ),
                        GButton(
                          icon: Icons.grading_outlined,
                          text: 'Grades',
                        ),
                        GButton(
                          icon: Icons.forum_outlined,
                          text: 'Forum',
                        ),
                        GButton(
                          icon: Icons.file_copy_outlined,
                          text: 'Resources',
                        )
                      ],
                    ),
                    Container(
                      child: subpages(course, user)[currentIndex],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Data not found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
