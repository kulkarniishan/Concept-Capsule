// More funtionalities to be added in future
import 'package:flutter/material.dart';

class GradesPage extends StatefulWidget {
  GradesPage({Key? key}) : super(key: key);

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Grades'),
      ), // Center
    ); // Container
  }
}
