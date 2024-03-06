import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionHandler {
  static Future<bool> requestLocationPermission(BuildContext context) async {
    // Check if location permission is already granted
    var status = await Permission.location.status;
    if (status.isGranted) {
      // Location permission is already granted
      return true;
    }

    // If permission is denied, show a dialog to request permission
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      if (context.mounted) {
        var result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Location Permission',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'This app needs access to your location to function properly.',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 10.0,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Deny'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Allow'),
                ),
              ],
            );
          },
        );

        // If user grants permission, request location permission
        if (result == true) {
          var status = await Permission.location.request();
          if (status.isGranted) {
            return true;
          }
        }
      }
    }

    // Location permission is not granted
    return false;
  }
}
