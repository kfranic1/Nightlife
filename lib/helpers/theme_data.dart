import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlife/helpers/primary_swatch.dart';

ThemeData themeData = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primarySwatch,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    elevation: 0,
    titleTextStyle: GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSpacing: 12,
  ),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.gochiHand(fontSize: 32),
    titleLarge: GoogleFonts.baloo2(fontSize: 20, color: Colors.white),
    titleMedium: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    labelSmall: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    //
    bodyLarge: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    bodyMedium: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    bodySmall: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    displayLarge: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    displayMedium: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    displaySmall: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    headlineMedium: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    headlineSmall: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    titleSmall: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    labelMedium: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
    labelLarge: GoogleFonts.baloo2(fontSize: 12, color: Colors.white),
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
    labelStyle: GoogleFonts.baloo2(
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
);
