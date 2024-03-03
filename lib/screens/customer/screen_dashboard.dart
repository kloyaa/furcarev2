import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/screens/customer/tabs/bookings.dart';
import 'package:furcarev2/screens/customer/tabs/dashboard.dart';
import 'package:furcarev2/screens/customer/tabs/pets.dart';
import 'package:furcarev2/screens/customer/tabs/settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomerMain extends StatefulWidget {
  const CustomerMain({super.key});

  @override
  State<CustomerMain> createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
  // State
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 70,
          vertical: 10.0,
        ),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Ionicons.home_outline,
              size: 15.0,
            ),
            title: Text(
              "Home",
              style: GoogleFonts.urbanist(
                fontSize: 10.0,
              ),
            ),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.pets_outlined,
              size: 15.0,
            ),
            title: Text(
              "Pets",
              style: GoogleFonts.urbanist(
                fontSize: 10.0,
              ),
            ),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.book_outlined,
              size: 15.0,
            ),
            title: Text(
              "Bookings",
              style: GoogleFonts.urbanist(
                fontSize: 10.0,
              ),
            ),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Ionicons.settings_outline,
              size: 15.0,
            ),
            title: Text(
              "Settings",
              style: GoogleFonts.urbanist(
                fontSize: 10.0,
              ),
            ),
            selectedColor: Colors.pink,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CustomerTabDashboard(),
          CustomerTabPets(),
          CustomerTabBookings(),
          CustomerTabSettings(),
        ],
      ),
    );
  }
}
