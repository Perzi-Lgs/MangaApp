import 'package:flutter/material.dart';

import 'config/routes/route_generator.dart';

void main() {
  runApp(Manga());
}

class Manga extends StatelessWidget {
  const Manga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
