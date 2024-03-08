import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewGrooming extends StatefulWidget {
  const PreviewGrooming({super.key});

  @override
  State<PreviewGrooming> createState() => _PreviewGroomingState();
}

class _PreviewGroomingState extends State<PreviewGrooming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Preview",
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: AppColors.secondary,
    );
  }
}
