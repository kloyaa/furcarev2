import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/widgets/gender_selection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class AdminStaffEnrollment extends StatefulWidget {
  const AdminStaffEnrollment({super.key});

  @override
  State<AdminStaffEnrollment> createState() => _AdminStaffEnrollmentState();
}

class _AdminStaffEnrollmentState extends State<AdminStaffEnrollment> {
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

  @override
  void initState() {
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
                          fontSize: 12.0,
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Enroll Staff",
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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            padding: const EdgeInsets.symmetric(
              horizontal: 100.0,
              vertical: 30.0,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25.0),
                Text(
                  "Account",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Username",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Email",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Password",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Confirm",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Text(
                  "Basic info",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "First name",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Last name",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Birthdate",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon:
                                const Icon(Ionicons.calendar_clear_outline),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: GenderSelectionWidget(
                          onGenderSelected: (gender) {
                            setState(() {
                              _selectedGender = gender!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Text(
                  "Address",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Present Address",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Permanent Address",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Text(
                  "Contact",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Email",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          decoration: InputDecoration(
                            fillColor: AppColors.primary,
                            labelText: "Mobile No.",
                            labelStyle: GoogleFonts.urbanist(
                              color: AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
