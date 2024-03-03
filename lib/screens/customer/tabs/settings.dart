import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CustomerTabSettings extends StatefulWidget {
  const CustomerTabSettings({super.key});

  @override
  State<CustomerTabSettings> createState() => _CustomerTabSettingsState();
}

class _CustomerTabSettingsState extends State<CustomerTabSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.urbanist(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.pink,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Ionicons.person_outline,
                color: AppColors.primary,
                size: 18.0,
              ),
              title: Text(
                'Profile',
                style: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              subtitle: Text(
                'Change your basic info and more',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 10.0,
                ),
              ),
              tileColor: Colors.white,
              onLongPress: () {},
              // Add any other content you want here
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(
                Ionicons.paw_outline,
                color: AppColors.primary,
                size: 18.0,
              ),
              title: Text(
                'Owner info',
                style: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              subtitle: Text(
                'I nfo that is visible to furcare staffs',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 10.0,
                ),
              ),
              tileColor: Colors.white,
              onLongPress: () {},
              // Add any other content you want here
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(
                Ionicons.list_outline,
                color: AppColors.primary,
                size: 18.0,
              ),
              title: Text(
                'Activity log',
                style: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              subtitle: Text(
                'See your furcare activities',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 10.0,
                ),
              ),
              tileColor: Colors.white,
              onLongPress: () {},
              // Add any other content you want here
            ),
            const SizedBox(height: 200.0),
            ListTile(
              leading: const Icon(
                Ionicons.log_out_outline,
                color: AppColors.primary,
                size: 18.0,
              ),
              title: Text(
                'Leave',
                style: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              subtitle: Text(
                'Sign out your account',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary,
                  fontSize: 10.0,
                ),
              ),
              tileColor: Colors.white,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              },
              // Add any other content you want here
            )
          ],
        ),
      ),
    );
  }
}
