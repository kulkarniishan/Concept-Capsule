import 'package:flutter/material.dart';
import 'package:mooc_app/pages/main_page.dart';
import 'package:mooc_app/pages/login_page.dart';
import 'package:mooc_app/pages/signup_page.dart';
import 'package:mooc_app/pages/SubPages/user_profile.dart';
import 'package:mooc_app/pages/SubPages/video_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/home": (context) => MainPage(),
        "/profile": (context) => UserProfile(),
        "/video": (context) => VideoDetail(),
      },
    );
  }
}
