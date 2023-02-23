import 'package:flutter/material.dart';
import 'package:mobile/config/themes/theme_config.dart';

class GenresButton extends StatelessWidget {
  GenresButton({required this.genre, required this.id});

  final String genre;
  final String id;

  String get getId => id;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          genre,
          style: TextStyle(color: CustomColors.white),
        ));
  }
}
