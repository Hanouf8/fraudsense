import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 203, 240, 179),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(
        const Color.fromARGB(255, 203, 240, 179),
      ),
      foregroundColor: MaterialStateProperty.all<Color?>(
        const Color.fromARGB(255, 0, 0, 0),
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(
      const Color.fromARGB(255, 109, 109, 109),
    ),
  )),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color.fromARGB(255, 203, 240, 179),
  ),
);
