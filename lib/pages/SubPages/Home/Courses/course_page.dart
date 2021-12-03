import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/course_page.dart';
import 'package:mooc_app/pages/SubPages/Home/Courses/subPages/instructors_page.dart';
import 'package:mooc_app/pages/SubPages/Home/Courses/subPages/overview_page.dart';

class CourseDescription extends StatefulWidget {
  final String courseId;
  final User user;
  CourseDescription({Key? key, required this.courseId, required this.user})
      : super(key: key);

  @override
  _CourseDescriptionState createState() =>
      _CourseDescriptionState(this.courseId, this.user);
}

class _CourseDescriptionState extends State<CourseDescription> {
  int currentIndex = 0;
  String courseId;
  User user;

  _CourseDescriptionState(this.courseId, this.user);

  subpages(course, user) {
    return ([
      overviewPage(description: course['description']),
      InstructorPage(instructor: course['instructor']),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // print(courseId);
    final userEnrolled = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('enrolledCourses')
        .doc(courseId);
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
                      FutureBuilder(
                        future: userEnrolled.get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data!.exists) {
                              final bool courseCompleted =
                                  snapshot.data!['complete'];
                              if (courseCompleted) {
                                return MaterialButton(
                                  height: 40,
                                  color: Colors.lightBlueAccent[100],
                                  onPressed: () {},
                                  child: Text(
                                    "Course Completed",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              } else {
                                return MaterialButton(
                                  height: 40,
                                  color: Colors.green[300],
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CoursePage(
                                            courseId: courseId, user: user),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Goto Course",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              }
                            } else {
                              return MaterialButton(
                                height: 40,
                                color: Colors.yellow,
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .collection('enrolledCourses')
                                      .doc(courseId)
                                      .set({
                                        'complete': false,
                                        'completedContent': [],
                                        'completedTime': Timestamp
                                            .fromMicrosecondsSinceEpoch(0),
                                        'instructor': course['instructor'],
                                        'name': course['name'],
                                        'thumbnail': course['thumbnail']
                                      }) // <-- Your data
                                      .then((_) => {
                                            Navigator.pop(context),
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CoursePage(
                                                        courseId: courseId,
                                                        user: user),
                                              ),
                                            ),
                                          })
                                      .catchError((error) =>
                                          print('Add failed: $error'));
                                },
                                child: Text(
                                  "Enroll",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      GNav(
                        rippleColor: (Colors.grey[
                            800])!, // tab button ripple color when pressed
                        hoverColor:
                            (Colors.grey[700])!, // tab button hover color
                        haptic: true, // haptic feedback
                        tabBorderRadius: 15,
                        duration: Duration(
                            milliseconds: 400), // tab animation duration
                        gap: 8, // the tab button gap between icon and text
                        color: Colors.grey[800], // unselected icon color
                        activeColor:
                            Colors.blue, // selected icon and text color
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
                            text: 'Course Overview',
                          ),
                          GButton(
                            icon: Icons.person_outline,
                            text: 'Instructors',
                          ),
                        ],
                      ),
                      Container(
                        child: subpages(course, user)[currentIndex],
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

//  Container(
//                         child: Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             course['description'],
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                         ),
//                       ),