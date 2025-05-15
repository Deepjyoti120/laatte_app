import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laatte/utils/design_colors.dart';

var darkTheme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily, //outfit
  // add custom font from asset
  brightness: Brightness.dark,
  useMaterial3: true,
  // backgroundColor: DesignColor.backgroundColorDarkMode,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black26,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black26,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    centerTitle: false,
  ),
  scaffoldBackgroundColor: Colors.black26,
);
var theme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily, //outfit
  brightness: Brightness.light,
  useMaterial3: true,
  // backgroundColor: DesignColor.backgroundColor,
  colorScheme: const ColorScheme.light(
    surface: DesignColor.backgroundColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black26),
    elevation: 0,
    centerTitle: false,
  ),
  scaffoldBackgroundColor: DesignColor.backgroundColor,
);
