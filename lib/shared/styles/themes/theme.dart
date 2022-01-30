import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color backgroundColor = Colors.white;
Color? darkRedColor = Colors.red[700];
Color greyColor = Colors.grey;
Color? redColor = Colors.red[300];
Color? lightRedColor = Colors.red[100];

ThemeData shopLightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: redColor),
    errorColor: Colors.red[600],
    textTheme: TextTheme(
      bodyText2: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: greyColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1)),
      bodyText1: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: redColor,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 1)),
    ),
    // primarySwatch: orangeColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: backgroundColor),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: redColor),
        titleTextStyle: GoogleFonts.nunito(
          textStyle: TextStyle(
            color: redColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 25,
          ),
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedLabelStyle: GoogleFonts.nunito(),
        unselectedLabelStyle: GoogleFonts.nunito(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: redColor,
        unselectedItemColor: greyColor));

