import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mooc_app/Widgets/AllCourses.dart';
import 'package:mooc_app/Widgets/EnrolledCourses.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(this.user);
}

class _HomePageState extends State<HomePage> {
  late User currentUser;
  //Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  User user;
  _HomePageState(this.user);

  @override
  void initState() {
    super.initState();
    // this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to ConceptCapsule!"),
        centerTitle: true,
      ),
      body: AllCourses(user: user),
    );
  }
}
