import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mooc_app/Widgets/CompletedCourses.dart';
import 'package:mooc_app/pages/login_page.dart';

class UserProfile extends StatefulWidget {
  final User user;
  UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState(this.user);
}

class _UserProfileState extends State<UserProfile> {
  //Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  User user;
  _UserProfileState(this.user);

  // Future checkAuthentication() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //       user = user;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.checkAuthentication();
  }

  logout() async {
    await Firebase.initializeApp();

    await auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ), // MaterialPageRoute
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(user);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ), // AppBar
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundImage: NetworkImage(
                            user.photoURL ?? 'https://picsum.photos/76'),
                      ), // CircleAvatar
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName.toString(),
                              style: TextStyle(fontSize: 18),
                            ), // Text
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                user.email.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.63),
                                ), // TextStyle
                              ), // Text
                            ), // Padding
                          ],
                        ), // Column
                      ), // Padding
                    ],
                  ), // Row
                  GestureDetector(
                    onTap: logout,
                    child: Column(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.black45,
                          size: 36.0,
                        ),
                        Text("Logout"),
                      ],
                    ), // Column
                  ) // GestureDetector
                ],
              ), // Row
              SizedBox(height: 30),
              Text(
                "Completed Courses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ), // TextStyle
              ), // Text
              SizedBox(height: 16),
              CompletedCourses(userId: user.uid)
              // CompletedCourses(userId: "gYPmlMV9iZffTArqlNAr")
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
