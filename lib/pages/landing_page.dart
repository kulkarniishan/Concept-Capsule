import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:mooc_app/pages/SubPages/video_detail.dart';
import 'package:mooc_app/pages/login_page.dart';
import 'dart:async';

import 'main_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // late FirebaseAuth auth;

  late FirebaseAuth auth;

  checkAuthentication() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // initializeFlutterFire();
    Timer(Duration(seconds: 5), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          // MaterialPageRoute(builder: (context) => VideoDetail()),
          (route) => false,
        );
      }
    });

    // await FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('hello');
    //     userStatus = 0;
    //     // Navigator.pushAndRemoveUntil(
    //     //   context,
    //     //   MaterialPageRoute(builder: (context) => LoginPage()),
    //     //   (route) => false,
    //     // );
    //   } else {
    //     print('User is signed in!');

    //     userStatus = 1;
    //     // Navigator.pushAndRemoveUntil(
    //     //   context,
    //     //   MaterialPageRoute(builder: (context) => MainPage()),
    //     //   (route) => false,
    //     // );
    //   }
    // });
    // print(userStatus);
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      setState(() {
        auth = FirebaseAuth.instance;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    this.initializeFlutterFire();
    this.checkAuthentication();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  final splashScreen = Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      margin: EdgeInsets.all(80.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo/logo-no-glow.png',
              scale: 1,
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Concept ',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(56, 187, 201, 1),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Capsule',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(215, 8, 38, 1),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: splashScreen,
    );
  }
}
