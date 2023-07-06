import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF34A853);
const Color secondaryColor = Color(0xFF309C4D);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.plusJakartaSans(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.plusJakartaSans(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.plusJakartaSans(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.plusJakartaSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.plusJakartaSans(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.plusJakartaSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.plusJakartaSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.plusJakartaSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.plusJakartaSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.plusJakartaSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.plusJakartaSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.plusJakartaSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.plusJakartaSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
