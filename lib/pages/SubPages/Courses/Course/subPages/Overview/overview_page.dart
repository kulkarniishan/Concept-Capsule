import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mooc_app/pages/video_detail.dart';

class OverviewPage extends StatefulWidget {
  final DocumentSnapshot course;
  final User user;
  OverviewPage({Key? key, required this.course, required this.user})
      : super(key: key);

  @override
  _OverviewPageState createState() =>
      _OverviewPageState(this.course, this.user);
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  DocumentSnapshot course;
  User user;

  _OverviewPageState(this.course, this.user);

  Widget build(BuildContext context) {
    Card card(video) {
      var heading = video['title'];
      var cardImage = NetworkImage(video['thumbnail']);
      return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
            ),
            Container(
              height: 100.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   alignment: Alignment.centerLeft,
            //   child: Text(supportingText),
            // ),
          ],
        ),
      );
    }

    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height * 3 / 5),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
            child: GridView.builder(
              itemCount: course['videos'].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 10.0,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetail(
                          videoLink: course['videos'][index]['url'],
                          userId: user.uid,
                          enrolledId: course.id,
                          contentId: index,
                          courseId: course.id,
                          videoTitle: course['videos'][index]['name'],
                          duration: course['videos'][index]['duration'],
                        ),
                      ),
                    );
                  },
                  child: card(course['videos'][index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
