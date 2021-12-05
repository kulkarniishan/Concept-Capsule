import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/SubPages/Home/Courses/course_page.dart';

class AllCourses extends StatefulWidget {
  final User user;
  AllCourses({Key? key, required this.user}) : super(key: key);

  @override
  _AllCoursesState createState() => _AllCoursesState(this.user);
}

class _AllCoursesState extends State<AllCourses> {
  User user;
  _AllCoursesState(this.user);

  final TextEditingController controller = TextEditingController();

  final CollectionReference<Map<String, dynamic>> AllCourses =
      FirebaseFirestore.instance.collection('course');

  bool search = false;

  late Query<Map<String, dynamic>> searchQuery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                onChanged: (value) => {
                  // print(value),
                  // print(controller.text.length),
                  setState(
                    () {
                      search = value.length == 0 ? false : true;
                      searchQuery = FirebaseFirestore.instance
                          .collection('course')
                          .where('name', isGreaterThanOrEqualTo: value)
                          .where('name', isLessThanOrEqualTo: value+'z');
                    },
                  ),
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    iconSize: 20.0,
                    onPressed: () {
                      //Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by Course Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Courses',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: search
                ? FutureBuilder(
                    future: searchQuery.get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final DocumentSnapshot Courses =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseDescription(
                                        courseId: Courses.id,
                                        user: user,
                                      ),
                                    ),
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
                                          Courses['thumbnail'],
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Courses['name'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            Courses['instructor'],
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.6),
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
                            },
                          );
                        } else {
                          return Center(
                            child: Text("No Courses Found"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                : FutureBuilder(
                    future: AllCourses.get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final DocumentSnapshot Courses =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseDescription(
                                        courseId: Courses.id,
                                        user: user,
                                      ),
                                    ),
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
                                          Courses['thumbnail'],
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Courses['name'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            Courses['instructor'],
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.6),
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
                            },
                          );
                        } else {
                          return Center(
                            child: Text("No Courses Found"),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
