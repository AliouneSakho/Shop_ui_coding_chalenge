import 'package:flutter/material.dart';

final themeData = ThemeData(
  fontFamily: 'Abel',
  scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
  brightness: Brightness.light,
  primarySwatch: Colors.lightGreen,
  indicatorColor: Colors.lightGreen.shade600,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(15.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    ),
  ),
);
