import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/course_page.dart';

class EnrolledCourses extends StatelessWidget {
  final User user;

  EnrolledCourses({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Query<Map<String, dynamic>> enrolledCourse = FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .collection('enrolledCourses')
        .where('complete', isEqualTo: false);
    return FutureBuilder<QuerySnapshot>(
      future: enrolledCourse.get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final DocumentSnapshot enCourse = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoursePage(
                                  courseId: enCourse.id,
                                  user: user,
                                )),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Image.network(
                              enCourse['thumbnail'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                enCourse['name'],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 5),
                              Text(
                                enCourse['instructor'],
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(height: 5),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
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
