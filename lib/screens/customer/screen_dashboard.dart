import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/classes/owner.dart';
import 'package:furcarev2/classes/pet.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/user.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/screens/customer/tabs/bookings.dart';
import 'package:furcarev2/screens/customer/tabs/dashboard.dart';
import 'package:furcarev2/screens/customer/tabs/pets.dart';
import 'package:furcarev2/screens/customer/tabs/settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomerMain extends StatefulWidget {
  const CustomerMain({super.key});

  @override
  State<CustomerMain> createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
  // State
  int _currentIndex = 0;
  String _accessToken = "";

  Future<void> handleGetOwnerProfile() async {
    ClientApi clientApi = ClientApi(_accessToken);
    try {
      Response<dynamic> response = await clientApi.getMeOwnerProfile();
      OwnerProfile ownerProfile = OwnerProfile.fromJson(response.data);
    } on DioException catch (e) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);
      if (errorResponse.code == "99000") {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/c/create/profile/owner');
        }
      }
    }
  }

  Future<void> handleGetPets() async {
    ClientApi clientApi = ClientApi(_accessToken);
    try {
      Response<dynamic> response = await clientApi.getMePets();

      List<Map<String, dynamic>> jsonDataList =
          List<Map<String, dynamic>>.from(response.data);

      List<Pet> pets = jsonDataList.map((json) => Pet.fromJson(json)).toList();

      if (pets.isEmpty) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/c/create/profile/pet');
        }
      }
    } on DioException catch (e) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';

    // handleGetOwnerProfile();
    handleGetPets();
  }

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
