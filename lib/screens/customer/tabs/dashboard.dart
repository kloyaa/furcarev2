import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerTabDashboard extends StatefulWidget {
  const CustomerTabDashboard({super.key});

  @override
  State<CustomerTabDashboard> createState() => _CustomerTabDashboardState();
}

class _CustomerTabDashboardState extends State<CustomerTabDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Text(
          'Services',
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
            Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/img_3.jpg',
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  'Boarding',
                  style: GoogleFonts.urbanist(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Ensure your furry friend's comfort and care while you're away. Choose from trusted facilities and caregivers for peace of mind.",
                  style: GoogleFonts.urbanist(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Add any other content you want here
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/img_2.jpg',
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  'Grooming',
                  style: GoogleFonts.urbanist(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Treat your pet to a spa day! Book professional grooming services to keep your furry friend looking and feeling their best.",
                  style: GoogleFonts.urbanist(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Add any other content you want here
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/img_4.jpg',
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  'Pick up and Drop off',
                  style: GoogleFonts.urbanist(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Convenient transportation solutions for your pet's needs. Schedule hassle-free pick-up and drop-off services to ensure seamless journeys.",
                  style: GoogleFonts.urbanist(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Add any other content you want here
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/img_1.jpg',
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  'Location',
                  style: GoogleFonts.urbanist(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Discover a haven for pet lovers! Visit our conveniently located pet shop for all your furry friend's needs.",
                  style: GoogleFonts.urbanist(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Add any other content you want here
              ),
            )
          ],
        ),
      ),
    );
  }
}
