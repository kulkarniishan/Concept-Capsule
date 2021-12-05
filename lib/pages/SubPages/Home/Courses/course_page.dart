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
                ), // Text
                centerTitle: true,
              ), // AppBar
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Image.network(
                      course['coverImage'],
                      height: 250,
                    ), // Image.network
                    FutureBuilder(
                      future: userEnrolled.get(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            final bool courseCompleted =
                                snapshot.data!['complete'];
                            if (courseCompleted) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: MaterialButton(
                                    height: 40,
                                    color: Colors.lightBlueAccent[100],
                                    onPressed: () {},
                                    child: Text(
                                      "Course Completed",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ), // TextStyle
                                    ), // Text
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ), // RoundedRectangleBorder
                                  ), // MaterialButton
                                ), // SizedBox
                              ); // Padding
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: MaterialButton(
                                    height: 40,
                                    color: Colors.green[300],
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CoursePage(
                                              courseId: courseId, user: user),
                                        ), // MaterialPageRoute
                                      );
                                    },
                                    child: Text(
                                      "Goto Course",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ), // TextStyle
                                    ), // Text
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ), // RoundedRectangleBorder
                                  ), // MaterialButton
                                ), // SizedBox
                              ); // Padding
                            }
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                height: 50.0,
                                child: MaterialButton(
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
                                                ), // MaterialPageRoute
                                              ),
                                            })
                                        .catchError(
                                          (error) =>
                                              // ignore: invalid_return_type_for_catch_error
                                              print('Add failed: $error'),
                                        );
                                  },
                                  child: Text(
                                    "Enroll",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ), // TextStyle
                                  ), // Text
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ), // RoundedRectangleBorder
                                ), // MaterialButton
                              ), // SizedBox
                            ); // Padding
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          ); //Center
                        }
                      },
                    ), // FutureBuilder
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
                        setState(
                          () {
                            currentIndex = index;
                            // print(index);
                          },
                        );
                      },
                      tabs: [
                        GButton(
                          icon: Icons.library_books_outlined,
                          text: 'Course Overview',
                        ), // GButton 
                        GButton(
                          icon: Icons.person_outline,
                          text: 'Instructors',
                        ),// GButton 
                      ],
                    ),// GNav
                    Container(
                      child: subpages(course, user)[currentIndex],
                    ),// Container
                  ],
                ), // Column
              ), // SingleChildScrollView
            ); // Scaffold
          } else {
            return Center(
              child: Text("Data not found"),
            ); // Center
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); // Center
        }
      },
    ); // FutureBuilder
  }
}
