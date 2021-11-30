import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/Widgets/EnrolledCourses.dart';
import 'package:mooc_app/pages/SubPages/Courses/Course/course_page.dart';

class CoursesPage extends StatefulWidget {
  final User user;
  CoursesPage({Key? key, required this.user}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState(this.user);
}

class _CoursesPageState extends State<CoursesPage> {
  late User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // card(context) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => CoursePage()),
  //       );
  //     },
  //     child: Container(
  //       child: Card(
  //         elevation: 5.0,
  //         margin: EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               child: Image.network(
  //                   "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/118898040/original/870e2763755963f5a300574bbea5977fa8b18460/sell-original-football-and-basketball-teams-jersey.jpg",
  //                   width: 100,
  //                   height: 100,
  //                   fit: BoxFit.fill),
  //             ),
  //             Column(
  //               children: [
  //                 Container(
  //                   child: Text('items[index].title',
  //                       // style: titleTextStyle,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis),
  //                   margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Container(
  //                     margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
  //                     child: Text(
  //                       'items[index].subtitle',
  //                       // style: subtitleTextStyle,
  //                     ),
  //                   ),
  //                 ),
  //                 // Container(
  //                 //   margin: EdgeInsets.all(8.0),
  //                 //   child: Row(
  //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 //     children: [
  //                 //       Text(formatter.output.symbolOnLeft, style: priceTextStyle),
  //                 //       Text("ADD TO CART", style: addToCardTextStyle)
  //                 //     ],
  //                 //   ),
  //                 // )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  User user;
  _CoursesPageState(this.user); //constructor

  // Future checkAuthentication() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //       currentUser = user;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses Enrolled'),
        centerTitle: true,
      ),
      body: EnrolledCourses(
        userId: user.uid,
      ),
    );
  }
}



       // child: Center(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(height: 30),
        //           Text(
        //             "Courses",
        //             style: TextStyle(
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold,
        //               fontStyle: FontStyle.italic,
        //             ),
        //           ),
        //           SizedBox(height: 12),
        //           ListView.builder(
        //             itemCount: 10,
        //             shrinkWrap: true,
        //             physics: const NeverScrollableScrollPhysics(),
        //             itemBuilder: (context, index) {
        //               return InkWell(
        //                 onTap: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(builder: (context) => CoursePage()),
        //                   );
        //                 },
        //                 child: Card(
        //                   elevation: 5,
        //                   color: Colors.white,
        //                   shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(15),
        //                   ),
        //                   child: Row(
        //                     children: [
        //                       Padding(
        //                         padding: EdgeInsets.all(15),
        //                         child: Image.network(
        //                           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Adobe_Photoshop_CC_icon.svg/768px-Adobe_Photoshop_CC_icon.svg.png",
        //                           width: 50,
        //                           height: 50,
        //                           fit: BoxFit.cover,
        //                         ),
        //                       ),
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text(
        //                             "Corel Draw",
        //                             style: TextStyle(fontSize: 16),
        //                           ),
        //                           SizedBox(height: 5),
        //                           Text(
        //                             "Jon Doe".toUpperCase(),
        //                             style: TextStyle(
        //                               fontSize: 14,
        //                               color: Color.fromRGBO(0, 0, 0, 0.6),
        //                             ),
        //                           ),
        //                           SizedBox(height: 12),
        //                           Text(
        //                             "Completed on 15 Sep, 2021",
        //                             style: TextStyle(
        //                               fontSize: 10,
        //                               color: Color.fromRGBO(0, 0, 0, 0.6),
        //                             ),
        //                           ),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),