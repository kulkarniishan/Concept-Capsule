import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnrolledCourses extends StatelessWidget {
  final String userId;

  EnrolledCourses({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference enrolledCourse = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('enrolledCourse');
    return FutureBuilder<QuerySnapshot>(
      future: enrolledCourse.get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(userId);
            print(snapshot.data!.docs.length);
          } else {
            return Center(
              child: Text("No users found."),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center();
      },
    );
  }
}
