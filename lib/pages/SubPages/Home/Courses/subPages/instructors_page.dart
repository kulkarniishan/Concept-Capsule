import 'package:flutter/material.dart';

class InstructorPage extends StatelessWidget {
  final String instructor;
  const InstructorPage({Key? key, required this.instructor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(instructor),
    );
  }
}
