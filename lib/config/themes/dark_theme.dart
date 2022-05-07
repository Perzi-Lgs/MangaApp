import 'package:flutter/material.dart';
import 'package:mobile/config/themes/theme_config.dart';

ThemeData get darkTheme {
  return ThemeData(
      primaryColor: CustomColors.darkGrey,
      secondaryHeaderColor: CustomColors.white,
      iconTheme: IconThemeData(color: CustomColors.mainBlue),
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            color: CustomColors.lightGrey,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        filled: true,
        fillColor: CustomColors.darkGrey,
        iconColor: CustomColors.white,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: CustomColors.white,
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
        headline2: TextStyle(
          color: CustomColors.white,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        bodyText1: TextStyle(
            color: CustomColors.white,
            fontSize: 10,
            fontWeight: FontWeight.w300),
        bodyText2: TextStyle(
            color: CustomColors.lightGrey,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        headline3: TextStyle(
            color: CustomColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
      appBarTheme: AppBarTheme(
        color: CustomColors.darkGrey,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: CustomColors.darkGrey,
          selectedItemColor: CustomColors.mainBlue,
          unselectedItemColor: CustomColors.lightGrey,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(CustomColors.buttonGrey),
      )));
}
