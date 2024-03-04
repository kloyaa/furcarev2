import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/staff.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/admin.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/utils/common.util.dart';
import 'package:furcarev2/widgets/gender_selection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminStaffManagement extends StatefulWidget {
  const AdminStaffManagement({super.key});

  @override
  State<AdminStaffManagement> createState() => _AdminStaffManagementState();
}

class _AdminStaffManagementState extends State<AdminStaffManagement> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _presentAddController = TextEditingController();
  final TextEditingController _permanentAddController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late final FocusNode _firstNameFocus;
  late final FocusNode _middleNameFocus;
  late final FocusNode _lastNameFocus;
  late final FocusNode _presentAddFocus;
  late final FocusNode _permanentAddFocus;
  late final FocusNode _mobileNoFocus;
  late final FocusNode _usernameFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmFocus;
  late final FocusNode _emailFocus;

  // State
  String _selectedGender = "male";
  String _accessToken = "";

  Future<void> handleCreateEkyc() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String middleName = _middleNameController.text.trim();
    String presentAddress = _presentAddController.text.trim();
    String permanentAddress = _permanentAddController.text.trim();
    String mobileNo = _mobileNoController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirm = _confirmController.text.trim();
    String email = _emailController.text.trim();
  }

  Future<List<dynamic>> handleGetStaffs() async {
    AdminApi adminApi = AdminApi(_accessToken);
    Response<dynamic> response = await adminApi.getStaffs();

    final staffs = response.data.toList();
    return staffs;
  }

  @override
  void initState() {
    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';

    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmFocus = FocusNode();
    _firstNameFocus = FocusNode();
    _middleNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _presentAddFocus = FocusNode();
    _permanentAddFocus = FocusNode();
    _mobileNoFocus = FocusNode();
    // _usernameController.text = "Kolya0001";
    // _passwordController.text = "Password@123";
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _firstNameFocus.dispose();
    _middleNameFocus.dispose();
    _lastNameFocus.dispose();
    _presentAddFocus.dispose();
    _permanentAddFocus.dispose();
    _mobileNoFocus.dispose();
    super.dispose();
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
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      "/a/profile",
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Profile",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 10.0,
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
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Staffs",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
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
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      "/a/management/staff/enrollment",
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Enroll Staff",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Sign out",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
                          fontSize: 10.0,
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.50,
          child: FutureBuilder<List<dynamic>>(
            future: handleGetStaffs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                final List<dynamic>? staffList = snapshot.data;
                return ListView.builder(
                  itemCount: staffList!.length,
                  itemBuilder: (context, index) {
                    final staff = staffList[index];
                    return Container(
                      padding: const EdgeInsets.all(50.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/avatar_male.png',
                                scale: 2,
                              ),
                              const SizedBox(height: 20.0),
                              ToggleSwitch(
                                initialLabelIndex: 0,
                                totalSwitches: 2,
                                activeBgColors: const [
                                  [Colors.green],
                                  [Colors.pink],
                                  [Colors.red]
                                ],
                                inactiveBgColor: Colors.grey.shade200,
                                customTextStyles: [
                                  GoogleFonts.urbanist(
                                    fontSize: 12.0,
                                  )
                                ],
                                minHeight: 30.0,
                                labels: const ['Active', 'Inactive'],
                                onToggle: (index) {
                                  print('switched to: $index');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(width: 50.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile",
                                style: GoogleFonts.urbanist(
                                  fontSize: 10.0,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Firstname",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['firstName'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 18.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lastname",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['lastName'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 18.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Birthday",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        formatBirthDate(
                                          DateTime.parse(
                                            staff['profile']['birthdate'],
                                          ),
                                        ),
                                        style: GoogleFonts.urbanist(
                                          fontSize: 18.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['gender'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 18.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "Account",
                                style: GoogleFonts.urbanist(
                                  fontSize: 10.0,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Username",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['username'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['email'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "Contact",
                                style: GoogleFonts.urbanist(
                                  fontSize: 10.0,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['contact']['email'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile No.",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['contact']['number'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "Address",
                                style: GoogleFonts.urbanist(
                                  fontSize: 10.0,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Present",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['address']['present'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 40.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Permanent",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.0,
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        staff['profile']['address']['present'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14.0,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      // title:,
                      // subtitle: Text(staff['email']),
                      // trailing: Text('Created: ${staff['createdAt'].toString()}'),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
