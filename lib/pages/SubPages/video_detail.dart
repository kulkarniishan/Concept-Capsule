import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  final String videoLink;
  final String userId;
  final String enrolledId;
  final String contentId;

  VideoDetail(
      {Key? key,
      required this.videoLink,
      required this.userId,
      required this.enrolledId,
      required this.contentId})
      : super(key: key);

  // VideoDetail({Key? key}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void videoProgressCheck() {
    if (_controller.value.position.inMilliseconds >=
        _controller.value.duration.inMilliseconds * .85) {
      users
          .doc(widget.userId)
          .collection("enrolledCourses")
          .doc(widget.enrolledId)
          .update({
            "completedContent":
                FieldValue.arrayUnion(widget.contentId as dynamic)
          })
          .then((value) => print("completedContent Updated"))
          .catchError((err) => print("Failed to update completedContent: $err"));
    }
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _controller.addListener(videoProgressCheck);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 5 / 8,
      autoInitialize: true,
      autoPlay: false,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: "Introduction to Photoshop",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: "\nVideo: 12 min",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ]),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            print("back pressed");
          },
        ),
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Container(
            height: 300,
            child: Chewie(controller: _chewieController),
          ),
        ],
      ),
    );
  }
}
