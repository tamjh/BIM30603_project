import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HYAppTheme {
  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double mediumFontSize = 20;
  static const double largeFontSize = 24;
  static const double xlargefontSize = 30;

  static final ThemeData normalTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: false,
      toolbarHeight: 80,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
    ),
    splashColor: Colors.transparent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Color.fromRGBO(253, 253, 253, 1),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: bodyFontSize,
        color: Colors.black,
        fontFamily: GoogleFonts.tapestry().fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: smallFontSize,
        color: Colors.black,
        fontFamily: GoogleFonts.tapestry().fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: mediumFontSize,
        color: Colors.black,
        fontFamily: GoogleFonts.tapestry().fontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: largeFontSize,
        color: Colors.black,
        fontFamily: GoogleFonts.tapestry().fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: xlargefontSize,
        color: Colors.black,
        fontFamily: GoogleFonts.tapestry().fontFamily,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromRGBO(255, 254, 222, 1),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.green; // Active (on) color
          }
          return const Color.fromARGB(
              255, 216, 216, 216); // Inactive (off) color
        },
      ),
    ),
  );
}
