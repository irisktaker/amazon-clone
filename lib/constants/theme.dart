import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    /// Scaffold Main Color
    scaffoldBackgroundColor: GlobalVariables.backgroundColor,

    /// Primary Light Theme Color
    colorScheme: const ColorScheme.light(
      primary: GlobalVariables.secondaryColor,
    ),

    /// For AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),

    /// For TextField
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: GlobalVariables.secondaryColor,
        ),
      ),
    ),
  );
}
