import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/Widgets/EnrolledCourses.dart';

class CoursesPage extends StatefulWidget {
  final User user;
  CoursesPage({Key? key, required this.user}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState(this.user);
}

class _CoursesPageState extends State<CoursesPage> {
  late User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  User user;
  _CoursesPageState(this.user);

  @override
  void initState() {
    super.initState();
    // this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses Enrolled'),
        centerTitle: true,
      ), // AppBar
      body: EnrolledCourses(
        user: user,
      ), // EnrolledCourses
    ); // Scaffold
  }
}
