import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        errorColor: Color.fromARGB(200, 255, 255, 255),
      ),
      home: LandingPage(),
    );
  }
}
