import 'package:flutter/material.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

ThemeData themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSpacing: 12,
  ),
  fontFamily: 'Baloo2',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontFamily: 'Michroma'),
    titleLarge: TextStyle(fontSize: 20, color: Colors.white),
    titleMedium: TextStyle(fontSize: 12, color: Colors.white),
    labelSmall: TextStyle(fontSize: 12, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 12, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 12, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white),
    displayLarge: TextStyle(fontSize: 12, color: Colors.white),
    displayMedium: TextStyle(fontSize: 12, color: Colors.white),
    displaySmall: TextStyle(fontSize: 12, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 12, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 12, color: Colors.white),
    titleSmall: TextStyle(fontSize: 12, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12, color: Colors.white),
    labelLarge: TextStyle(fontSize: 12, color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Colors.white),
    ),
    iconColor: Colors.white,
    suffixIconColor: Colors.white,
    prefixIconColor: Colors.white,
    labelStyle: const TextStyle(
      fontSize: 12,
      color: Colors.white,
    ),
  ),
  dividerColor: Colors.transparent,
  tabBarTheme: const TabBarTheme(
    labelPadding: EdgeInsets.zero,
    unselectedLabelColor: Colors.white,
    labelColor: primaryColor,
  ),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch, brightness: Brightness.dark),
);
