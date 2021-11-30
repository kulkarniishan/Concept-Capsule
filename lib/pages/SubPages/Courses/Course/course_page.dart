import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Forum/forum_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Grades/grades_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Overview/overview_page.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/subPages/Resources/resources_page.dart';

class CoursePage extends StatefulWidget {
  final String courseId;
  CoursePage({Key? key, required this.courseId}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState(courseId);
}

class _CoursePageState extends State<CoursePage> {
  int currentIndex = 0;
  String courseId;
  _CoursePageState(this.courseId);

  final subpages = [
    OverviewPage(),
    GradesPage(),
    ForumPage(),
    ResourcesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Course',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Image.network(
              'https://ghru.edu.in/onlinecourse/admin/courses/python_banner.jpg'),
          GNav(
            rippleColor:
                (Colors.grey[800])!, // tab button ripple color when pressed
            hoverColor: (Colors.grey[700])!, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            duration: Duration(milliseconds: 400), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.blue, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor:
                Colors.blue.withOpacity(0.2), // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 5), // navigation bar padding
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
                print(index);
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
            child: subpages[currentIndex],
          ),
        ],
      ),
    );
  }
}
