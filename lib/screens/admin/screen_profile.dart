import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/admin_profile.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/user.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  // State
  String _accessToken = ''; // Initialize with an empty string
  AdminProfileModel? _adminProfileModel;

  Future<void> _handleGetProfile() async {
    if (_accessToken.isNotEmpty) {
      ClientApi clientApi = ClientApi(_accessToken);

      try {
        final profileData = await clientApi.getMeProfile();
        final profile = AdminProfileModel.fromJson(profileData.data);

        setState(() {
          _adminProfileModel = profile;
        });
      } on DioException catch (e) {
        print(e.response);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';

    // Call the method to handle getting the profile
    _handleGetProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Profile",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    // onTap: () => navigate(context, route: "/admin/reports"),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Reports",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      "/a/management/staff",
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Staffs",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    // onTap: () => navigate(context, route: "/admin/user-list"),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Users and Pets",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Sign out",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/${_adminProfileModel?.gender == "male" ? 'avatar_male.png' : 'avatar_female.png'}",
                      scale: 1.2,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Role",
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Ionicons.shield_checkmark_outline,
                          size: 18.0,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                    Text(
                      "Administrator",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(50.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hi! ${_adminProfileModel?.firstName} ${_adminProfileModel?.lastName}",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 82.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          _adminProfileModel?.gender == "male"
                              ? Icons.male
                              : Icons.female,
                          size: 18.0,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                    Text(
                      _adminProfileModel?.gender.toUpperCase() ?? "",
                      style: GoogleFonts.urbanist(
                        color: _adminProfileModel?.gender == "male"
                            ? Colors.blueAccent
                            : Colors.pinkAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Birthday",
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.cake_outlined,
                          size: 18.0,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                    Text(
                      formatBirthDate(
                        _adminProfileModel?.birthdate ?? DateTime.now(),
                      ),
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Email",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _adminProfileModel?.contact['email'] ?? "",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Mobile No.",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _adminProfileModel?.contact['number'] ?? "",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: AppColors.primary.withOpacity(0.2),
                        height: 0.1,
                      ),
                    ),
                    Text(
                      "Present address",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _adminProfileModel?.address['present'] ?? "",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Permanent address",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _adminProfileModel?.address['permanent'] ?? "",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
