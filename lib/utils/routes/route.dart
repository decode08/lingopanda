import 'package:flutter/material.dart';
import 'package:lingopanda/utils/routes/routes_name.dart';
import 'package:lingopanda/view/homepage.dart';
import 'package:lingopanda/view/login_screen.dart';
import 'package:lingopanda/view/signup_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login_screen:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case RoutesName.signup_screen:
        return MaterialPageRoute(builder: (context) => SignupPage());
      case RoutesName.homescreen:
        return MaterialPageRoute(builder: (context) => Homepage());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
