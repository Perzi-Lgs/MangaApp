import 'package:flutter/material.dart';
import 'package:mobile/config/themes/theme_config.dart';

ThemeData get darkTheme {
  return ThemeData(
    primaryColor: CustomColors.darkGrey,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: CustomColors.white,
        fontSize: 21,
        fontWeight: FontWeight.w500,
      )
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      buttonColor: CustomColors.lightPurple,
    ),
    appBarTheme: AppBarTheme(
      color: CustomColors.darkGrey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: CustomColors.darkGrey,
      selectedItemColor: CustomColors.mainBlue,
      unselectedItemColor: CustomColors.lightGrey,
      selectedLabelStyle: TextStyle(
        fontSize: 10
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10
      )
    )
  );
}
