import 'package:flutter/material.dart';

class overviewPage extends StatelessWidget {
  final String description;
  const overviewPage({Key? key,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(description),
    );
  }
}