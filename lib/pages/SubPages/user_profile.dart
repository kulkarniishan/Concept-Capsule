import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mooc_app/pages/login_page.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  late User current_user;

  Future checkAuthentication() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        current_user = user;
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
                              backgroundImage:
                                  NetworkImage('https://picsum.photos/76'),
                            ),
                            Column(
                              children: [
                                Text(
                                  current_user.displayName.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    current_user.email.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(0, 0, 0, 0.63),
                                    ),
                                  ),
                                ),
                              ],
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
                    SizedBox(height: 18),
                    Text(
                      "Account Setting",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 12),
                    Card(
                      elevation: 5,
                      color: Colors.white,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Update Account Details"),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
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
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
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
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Adobe_Photoshop_CC_icon.svg/768px-Adobe_Photoshop_CC_icon.svg.png",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Advance Photoshop",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Willam Scott".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Completed on 15 Sep, 2021",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "With 100% Grade",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
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
