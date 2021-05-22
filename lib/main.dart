import 'package:flutter/material.dart';

void main() {
  runApp(MangaScan());
}

class MangaScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaScan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

