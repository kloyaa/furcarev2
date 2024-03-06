import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/utils/location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';

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
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/book/boarding',
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    'assets/img_3.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // Add any other content you want here
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/book/grooming',
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    'assets/img_2.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/book/transit',
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    'assets/img_4.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
            ),
            GestureDetector(
              onTap: () async {
                final availableMaps = await MapLauncher.installedMaps;
                final coordinates = await getCurrentCoordinates();
                await availableMaps.first.showDirections(
                  origin: Coords(coordinates[0], coordinates[1]),
                  destination: Coords(8.475595321127928, 124.66306220357012),
                  directionsMode: DirectionsMode.driving,
                  destinationTitle: "Furcare Veterinary Clinic",
                  originTitle: "My location",
                );
              },
              child: Card(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
