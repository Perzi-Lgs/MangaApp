import 'package:flutter/material.dart';
import '../../features/homepage/presentation/pages/homePage/homePage.dart';
import '../../core/errors/error_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments; // To pass argument to another page

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
    }
    return errorRoute();
  }
}
