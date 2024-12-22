import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HYAppTheme {
  static double bodyFontSize = 14.sp;
  static double smallFontSize = 16.sp;
  static double mediumFontSize = 20.sp;
  static double largeFontSize = 24.sp;
  static double xlargefontSize = 30.sp;

  static final ThemeData normalTheme = ThemeData(
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: false,
      toolbarHeight: 80,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.transparent,
      
    ),
    
    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory, // No splash effect for ElevatedButton
      ),
    ),
    
    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory, // No splash effect for TextButton
      ),
    ),
    
    // OutlinedButton Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory, // No splash effect for OutlinedButton
      ),
    ),
    
    // Button Theme for general buttons
    buttonTheme: const ButtonThemeData(
      splashColor: Colors.transparent,  // Disable splash globally
      highlightColor: Colors.transparent,
    ),
    
    // IconButton Theme
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory, // No splash effect for IconButton
      ),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
    ),

    // Scaffold background color
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),

    // Text Theme
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
    
    // Drawer Theme
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(223, 223, 29, 1),
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color.fromARGB(255, 193, 197, 193); // Active (on) color
          }
          return const Color.fromARGB(255, 216, 216, 216); // Inactive (off) color
        },
      ),
    ),

    // Splash Color & Highlight Color
    splashColor: Colors.transparent,  // Disable splash globally
    highlightColor: Colors.transparent,  // Disable highlight globally
    splashFactory: NoSplash.splashFactory,  // Ensure no splash effect everywhere
  );
}