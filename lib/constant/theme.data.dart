import 'package:flutter/material.dart';

class AppTheme {
  customAppTheme() {
    return ThemeData(
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: "Poppins"),
            bodyMedium: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
            bodySmall: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins")));
  }
}
