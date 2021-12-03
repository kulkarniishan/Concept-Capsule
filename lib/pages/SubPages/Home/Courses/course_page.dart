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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Course Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: course.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // print(snapshot.data!['name']);
                final DocumentSnapshot course = snapshot.data!;
                // print(snapshot.data?.toString());
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image.network(
                        course['coverImage'],
                        height: 250,
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            course['description'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Course Instructor : "+course['instructor'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
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
          }),
    );
  }
}
