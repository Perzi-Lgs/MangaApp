import 'package:flutter/material.dart';
import '../../core/errors/error_route.dart';
import '../../presentation/pages/app_body.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments; // To pass argument to another page

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AppBody());
    }
    return errorRoute();
  }
}
