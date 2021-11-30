import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mooc_app/Widgets/CompletedCourses.dart';
import 'package:mooc_app/pages/login_page.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  late User currentUser;

  Future checkAuthentication() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        currentUser = user;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  logout() async {
    await Firebase.initializeApp();

    await auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: checkAuthentication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundImage: NetworkImage(
                                    currentUser.photoURL ??
                                        'https://picsum.photos/76'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentUser.displayName.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        currentUser.email.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 0, 0, 0.63),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: logout,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: Colors.black45,
                                  size: 36.0,
                                ),
                                Text("Logout"),
                              ],
                            ),
                          )
                        ],
                      ),
                      // SizedBox(height: 18),
                      // Text(
                      //   "Account Setting",
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      // ),
                      // SizedBox(height: 12),
                      // Card(
                      //   elevation: 5,
                      //   color: Colors.white,
                      //   shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(14),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text("Update Account Details"),
                      //         Icon(Icons.chevron_right),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 30),
                      Text(
                        "Completed Courses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 16),
                      CompletedCourses(userId: currentUser.uid)
                      // CompletedCourses(userId: "gYPmlMV9iZffTArqlNAr")
                    ]),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
