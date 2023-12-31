import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF34A853);
const Color secondaryColor = Color(0xFF309C4D);

const Color errorColor = Color(0xFFE31A1A);

class AppTypography {
  static final TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle semiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, // FontWeight.w600 corresponds to semiBold
  );

  static final TextStyle medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // FontWeight.w500 corresponds to medium
  );

  static final TextStyle regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
}
