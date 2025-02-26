// lib/utils/app_fonts.dart
import 'package:flutter/material.dart';  // Importante: Esta línea era la que faltaba
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle aspenTitleStyle(double fontSize) {
    return TextStyle(
      fontFamily: 'Hiatus',
      fontSize: fontSize,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    );
  }

  static TextStyle subtitleStyle(double fontSize) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    );
  }static TextStyle subtitleStyle2(double fontSize) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }

  static TextStyle botonInicio(double fontsize){
    return GoogleFonts.outfit(
      fontSize: fontsize,
      fontWeight:FontWeight.w100,
      color: Colors.white,
    );
  }
}