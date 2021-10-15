import 'package:flutter/material.dart';

class MangeAppBar extends StatelessWidget {

  MangeAppBar(this.title);
  final String title;

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      key: Key("mangaAppBar"),
      title: Text(title),
    );
  }
}