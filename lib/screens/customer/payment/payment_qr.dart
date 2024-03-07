import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadQR extends StatefulWidget {
  final String paymentMethod;
  final String referenceNo;
  final String date;

  const UploadQR({
    Key? key,
    required this.paymentMethod,
    required this.referenceNo,
    required this.date,
  }) : super(key: key);

  @override
  State<UploadQR> createState() => _UploadQRState();
}

class _UploadQRState extends State<UploadQR> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.paymentMethod,
          style: GoogleFonts.urbanist(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            GestureDetector(
              onTap: () {
                _selectImage();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        "assets/image_placeholder.png",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 40.0),
            Text(
              "Ref No. FURC${widget.referenceNo.toUpperCase().substring(10, widget.referenceNo.length)}",
              style: GoogleFonts.urbanist(
                color: AppColors.primary,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              "Date ${formatDate(DateTime.parse(widget.date))}",
              style: GoogleFonts.urbanist(
                color: AppColors.primary.withOpacity(0.6),
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(flex: 3),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, "/c/main");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Finish',
                    style: GoogleFonts.urbanist(
                      color: AppColors.secondary,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
