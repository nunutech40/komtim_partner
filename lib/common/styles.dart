import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF34A853);
const Color secondaryColor = Color(0xFF309C4D);

class AppTypography {
  static final TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // FontWeight.w500 corresponds to medium
  );

  static final TextStyle regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
