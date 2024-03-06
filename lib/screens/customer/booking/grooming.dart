import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BookGrooming extends StatefulWidget {
  const BookGrooming({super.key});

  @override
  State<BookGrooming> createState() => _BookGroomingState();
}

class _BookGroomingState extends State<BookGrooming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Grooming",
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
