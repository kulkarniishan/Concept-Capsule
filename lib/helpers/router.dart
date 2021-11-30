import 'package:flutter/material.dart';
import 'package:mooc_app/pages/main_page.dart';
import 'package:mooc_app/pages/login_page.dart';
import 'package:mooc_app/pages/SubPages/video_detail.dart';
import 'package:mooc_app/constants/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HOME_ROUTE:
      return MaterialPageRoute(builder: (context) => MainPage());
    case LOGIN_ROUTE:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case VIDEOdETAIL_ROUTE:
      return MaterialPageRoute(builder: (context) => VideoDetail());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
