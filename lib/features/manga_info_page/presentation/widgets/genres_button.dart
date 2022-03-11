import 'package:flutter/material.dart';
import 'package:mobile/config/themes/theme_config.dart';

class GenresButton extends StatelessWidget {
  GenresButton({required this.genre});

  final String genre;

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
