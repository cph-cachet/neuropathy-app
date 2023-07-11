import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that holds the text styles for the app.
class AppTextStyle {
  static TextStyle header1 = GoogleFonts.workSans(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000));

  static TextStyle headline24sp = GoogleFonts.ibmPlexSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM18sp = GoogleFonts.ibmPlexSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM20sp = GoogleFonts.ibmPlexSans(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM22sp = GoogleFonts.ibmPlexSans(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM16sp = GoogleFonts.ibmPlexSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle extraLightIBM16sp = GoogleFonts.ibmPlexSans(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    color: const Color(0xFF000000),
  );

  static TextStyle regularIBM14sp = GoogleFonts.ibmPlexSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );

  static TextStyle toggleButtonStyle = const TextStyle(
    fontSize: 15,
    fontFamily: "Roboto",
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 15 / 15,
    letterSpacing: 0,
  );

  static TextStyle resultSectionLabelStyle = regularIBM14sp.copyWith(
    letterSpacing: -0.04,
    fontWeight: FontWeight.w200,
    color: Colors.black54,
  );

  static TextStyle resultsSmallLabelStyle = GoogleFonts.ibmPlexSansCondensed(
    fontSize: 12,
    letterSpacing: -0.04,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static TextStyle resultsLabelsStyle = extraLightIBM16sp.copyWith(
    letterSpacing: -0.04,
    fontWeight: FontWeight.w400,
  );
}
