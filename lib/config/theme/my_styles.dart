
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_blind/config/theme/themeColors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  MyStyles._();

  static ElevatedButtonThemeData getElevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  static TextStyle poppins = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.white,
  );
  static TextStyle mediumPoppins = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallPoppinsWhite = GoogleFonts.poppins(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallOutfitWhite = GoogleFonts.outfit(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle outfitNormalGray = GoogleFonts.outfit(
    fontSize: 12,
    color: ThemeColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle OutfitBlack = GoogleFonts.outfit(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w800,
  );
  static TextStyle verySmallOutfitBlack = GoogleFonts.outfit(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallOutWhite = GoogleFonts.outfit(
    fontSize: 16,
    color: ThemeColors.darkRed,
    fontWeight: FontWeight.w500,
  );
  static TextStyle normalSmall = const TextStyle(fontSize: 10, color: Colors.white);
  static TextStyle smallPoppinsBlue = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w300,
  );
  static TextStyle mediumPoppinsBlue = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w500,
  );

  static TextStyle poppinsBlackBold = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle poppinsBlack = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.black,
  );

  static TextStyle smallPoppinsBlack = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallPoppinsWhiteNormal = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallPoppinsBlackBold = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallPoppinsBlueBold = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mediumPoppinsBlueItalic = GoogleFonts.poppins(
    fontSize: 16,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic, // Set to italic
  );
  static TextStyle smallPoppinsBlueItalic = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic, // Set to italic
  );

  static TextStyle mediumPoppinsBlueBold = GoogleFonts.poppins(
    fontSize: 16,
    color: ThemeColors.blue,
    fontWeight: FontWeight.bold,
  );
  static TextStyle mediumPoppinsBlackBold = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumPoppinsLightBlueBoldUnderLine = GoogleFonts.poppins(
    fontSize: 16,
    color: const Color(0xFF044AFF),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationColor: ThemeColors.blue,
  );
  static TextStyle smallPoppinsLightBlueBoldUnderLine = GoogleFonts.poppins(
    fontSize: 12,
    color: const Color(0xFF044AFF),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationColor: ThemeColors.blue,
  );
  static TextStyle smallPoppinsBlueUnderLine = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.underline,
    decorationColor: ThemeColors.blue,
  );
  static TextStyle mediumPoppinsBlueUnderLine = GoogleFonts.poppins(
    fontSize: 16,
    color: ThemeColors.blue,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
    decorationColor: ThemeColors.blue,
  );
  static TextStyle mediumPoppinsWhite = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumPoppinsWhiteNormal = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static TextStyle mediumPoppinsWhiteBold = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle largePoppinsWhite = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle largePoppinsBlack = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle largePoppinsBlue = GoogleFonts.poppins(
    fontSize: 20,
    color: ThemeColors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle largePoppinsLightBlue = GoogleFonts.poppins(
    fontSize: 25,
    color: const Color(0xFF29A6D9),
    fontWeight: FontWeight.w500,
  );

  // black
  static TextStyle smallPoppinsBlack1 = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blueLight,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallPoppinsBlackWhite = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallPoppinsBlueBlackBox = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blueLight,
    fontWeight: FontWeight.w300,
  );
  static TextStyle mediumPoppinsBlueBlackBox = GoogleFonts.poppins(
    fontSize: 12,
    color: ThemeColors.blueLight,
    fontWeight: FontWeight.w500,
  );
}
