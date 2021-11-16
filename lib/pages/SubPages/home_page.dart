import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                      backgroundImage: NetworkImage('https://picsum.photos/76'),
                    ),
                    Column(
                      children: [
                        Text(
                          "Hi, Dev Sharma",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "dev123@gmail.com",
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
                  onTap: () {
                    print("object");
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 36.0,
                      ),
                      Icon(
                        Icons.notification_add,
                        color: Colors.black,
                        size: 36.0,
                      ),
                    ],
                  ),
                )
              ],
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
              "Courses in progress",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 12),
            ListView.builder(
              itemCount: 1,
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
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Corel Draw",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Jon Doe".toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Completed on 15 Sep, 2021",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
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
            SizedBox(height: 14),
            ListView.builder(
              itemCount: 1,
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
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Advance Photoshop",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Willam Scott".toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Completed on 15 Sep, 2021",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "With 100% Grade",
                            style: TextStyle(
                              fontSize: 10,
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
    ));
  }
}
