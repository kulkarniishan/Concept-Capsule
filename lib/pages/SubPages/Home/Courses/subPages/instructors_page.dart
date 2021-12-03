import 'package:flutter/material.dart';

class InstructorPage extends StatelessWidget {
  final String instructor;
  const InstructorPage({Key? key, required this.instructor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Course Instructor : " + instructor,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
