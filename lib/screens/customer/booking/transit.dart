import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BookTransit extends StatefulWidget {
  const BookTransit({super.key});

  @override
  State<BookTransit> createState() => _BookTransitState();
}

class _BookTransitState extends State<BookTransit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Transit",
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
