import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.teal,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[100],
      primaryColor: Colors.teal,
      useMaterial3: true,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueGrey,
      ),
      fontFamily: 'Nunito',
      listTileTheme: ListTileThemeData(
        tileColor: Colors.grey[200],
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static TextStyle get textStyle {
    return TextStyle(
      color: AppTheme.theme.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}