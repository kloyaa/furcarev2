import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color color = AppColors.primary,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: GoogleFonts.urbanist(
        fontSize: 9.0,
      ),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
