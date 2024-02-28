import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PopConfirm extends StatelessWidget {
  final String title;
  final String content;
  final Future<void> Function() onOk;

  const PopConfirm({
    Key? key,
    required this.title,
    required this.content,
    required this.onOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 70.0,
        vertical: 24.0,
      ),
      title: Text(title,
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          )),
      content: Text(content,
          style: GoogleFonts.urbanist(
            color: AppColors.primary,
            fontSize: 12.0,
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No',
              style: GoogleFonts.urbanist(
                color: AppColors.primary.withOpacity(0.5),
                fontSize: 12.0,
              )),
        ),
        TextButton(
          onPressed: () async {
            await onOk();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Text('Yes',
              style: GoogleFonts.urbanist(
                color: AppColors.primary,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}
