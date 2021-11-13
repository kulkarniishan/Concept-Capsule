import 'package:flutter/material.dart';
import 'package:mooc_app/pages/home_page.dart';
import 'package:mooc_app/pages/login_page.dart';
import 'package:mooc_app/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HOME_ROUTE:
      return MaterialPageRoute(builder: (context) => HomePage());
    case LOGIN_ROUTE:
      return MaterialPageRoute(builder: (context) => LoginPage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
