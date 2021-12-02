
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/core/component/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MangaAppBar(title: "Manga Rock"),
    );
  }
}
