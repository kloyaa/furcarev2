import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color color = AppColors.primary,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
