import 'package:flutter/material.dart';

import 'genres_button.dart';

class GenreButtonlist extends StatelessWidget {
  const GenreButtonlist({Key? key, required this.genres}) : super(key: key);

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _generate(),
    );
  }

  List<Widget> _generate() {
    return genres
        .map((e) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: GenresButton(genre: e),
            ))
        .toList();
  }
}