import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HYAppTheme {
  static double bodyFontSize = 14.sp;
  static  double smallFontSize = 16.sp;
  static  double mediumFontSize = 20.sp;
  static  double largeFontSize = 24.sp;
  static  double xlargefontSize = 30.sp;

  static final ThemeData normalTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: false,
      toolbarHeight: 80,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.transparent,
    ),
    splashColor: const Color.fromARGB(0, 255, 255, 255),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(253, 253, 253, 1),
    
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
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(240, 240, 239, 1),
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
