import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color color = AppColors.primary,
  double fontSize = 9.0,
  int duration = 3,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: GoogleFonts.urbanist(
        fontSize: fontSize,
      ),
    ),
    backgroundColor: color,
    duration: Duration(seconds: duration),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
