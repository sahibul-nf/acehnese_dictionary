import 'package:acehnese_dictionary/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle fontStyle({
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
  }) =>
      GoogleFonts.poppins(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? AppColor.black,
        height: height ?? 1.5,
      );
}
