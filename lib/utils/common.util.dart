import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

bool isEmail(String input) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );
  return emailRegex.hasMatch(input);
}

String formatDate(DateTime date) {
  return DateFormat("MMMM d, yyyy 'at' h:mma").format(date);
}

String formatToISOString(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}

String formatBirthDate(DateTime date) {
  return DateFormat("MMMM d, yyyy").format(date);
}

Color defineColorByStatus(String status) {
  if (status == "done") {
    return Colors.green;
  }
  if (status == "declined") {
    return AppColors.danger;
  }

  if (status == "confirmed") {
    return AppColors.primary;
  }

  if (status == "pending") {
    return AppColors.primary.withOpacity(0.3);
  }

  if (status == "cancelled") {
    return AppColors.danger.withOpacity(0.3);
  }

  return AppColors.primary;
}

bool validateFieldNotEmpty(String value, FocusNode focusNode) {
  if (value.isEmpty) {
    focusNode.requestFocus();
    return false;
  }
  return true;
}

Icon getIconByService(String service) {
  if (service == "grooming") {
    return const Icon(
      Ionicons.cut_outline,
      color: Colors.purple,
    );
  }
  if (service == "transit") {
    return const Icon(
      Ionicons.car_outline,
      color: Colors.deepOrange,
    );
  }
  if (service == "boarding") {
    return const Icon(
      Ionicons.paw_outline,
      color: Colors.brown,
    );
  }

  return const Icon(Ionicons.checkbox_outline);
}
