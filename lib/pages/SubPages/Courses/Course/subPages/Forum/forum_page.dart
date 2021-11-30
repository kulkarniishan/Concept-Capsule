import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Forum'),
      ),
    );
  }
}
