import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posta/utils/dimensions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(useMaterial3: true).copyWith(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.indigo,
          overlayColor: MaterialStatePropertyAll(
            Colors.indigo,
          ),
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.aBeeZee(
            fontSize: 25,
            color: Colors.black,
          ),
          labelLarge: GoogleFonts.aBeeZee(
            fontSize: Dimensions.elevatedButtonFontSize,
            color: Colors.black,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          primary: Colors.black54,
          secondary: Colors.indigo,
          scrim: Colors.black,
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF212C88),
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.aBeeZee(
            fontSize: 25,
          ),
          labelLarge: GoogleFonts.aBeeZee(
            fontSize: Dimensions.elevatedButtonFontSize,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.grey,
          secondary: Color(0xFF1F2977),
          scrim: Colors.white,
        ),
      );
}
