import 'package:dio/dio.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/client.dart';
import 'package:furcarev2/classes/ekyc.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/classes/registration.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/admin.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/widgets/gender_selection.dart';
import 'package:furcarev2/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AdminStaffEnrollment extends StatefulWidget {
  const AdminStaffEnrollment({super.key});

  @override
  State<AdminStaffEnrollment> createState() => _AdminStaffEnrollmentState();
}

class _AdminStaffEnrollmentState extends State<AdminStaffEnrollment> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _presentAddController = TextEditingController();
  final TextEditingController _permanentAddController = TextEditingController();
  final _mobileNoController = MaskedTextController(mask: '0000-000-000');
  final TextEditingController _birthdateController =
      MaskedTextController(mask: '0000/00/00');
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late final FocusNode _firstNameFocus;
  late final FocusNode _lastNameFocus;
  late final FocusNode _presentAddFocus;
  late final FocusNode _permanentAddFocus;
  late final FocusNode _mobileNoFocus;
  late final FocusNode _usernameFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmFocus;
  late final FocusNode _emailFocus;

  late final FocusNode _birthdateFocus;

  // State
  String _selectedGender = "male";
  String _accessToken = "";
  String _registrationErrorMessage = "";
  bool _isCreateError = false;
  bool _isPasswordVisible = false;
  bool _isPasswordMatched = true;

  Future<void> handleCreateEkyc() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String presentAddress = _presentAddController.text.trim();
    String permanentAddress = _permanentAddController.text.trim();
    String mobileNo = _mobileNoController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirm = _confirmController.text.trim();
    String email = _emailController.text.trim();
    String birthdate = _birthdateController.text.trim();

    if (username.isEmpty) {
      return _usernameFocus.requestFocus();
    }
    if (email.isEmpty) {
      return _emailFocus.requestFocus();
    }
    if (mobileNo.isEmpty) {
      return _mobileNoFocus.requestFocus();
    }
    if (password.isEmpty) {
      return _passwordFocus.requestFocus();
    }
    if (confirm.isEmpty) {
      return _confirmFocus.requestFocus();
    }

    if (firstName.isEmpty) {
      return _firstNameFocus.requestFocus();
    }
    if (lastName.isEmpty) {
      return _lastNameFocus.requestFocus();
    }
    if (birthdate.isEmpty) {
      return _birthdateFocus.requestFocus();
    }
    if (presentAddress.isEmpty) {
      return _presentAddFocus.requestFocus();
    }
    if (permanentAddress.isEmpty) {
      return _permanentAddFocus.requestFocus();
    }
    if (password != confirm) {
      setState(() {
        _isPasswordMatched = false;
      });

      return;
    }

    try {
      AdminApi adminApi = AdminApi(_accessToken);
      Ekyc ekyc = Ekyc(
        account: Account(
          email: email,
          username: username,
          password: password,
        ),
        profile: Profile(
          firstName: firstName,
          lastName: lastName,
          birthdate: birthdate.replaceAll("/", "-"),
          gender: _selectedGender,
          address: Address(
            permanent: permanentAddress,
            present: presentAddress,
          ),
          contact: Contact(
            email: email,
            number: "0${mobileNo.replaceAll('-', '')}",
          ),
          isActive: true,
        ),
      );
      await adminApi.enrollment(ekyc);

      setState(() {
        _isCreateError = false;
        _isPasswordMatched = true;
        _registrationErrorMessage = "";
      });

      if (context.mounted) {
        showSnackBar(
          context,
          "Registration successful!",
          color: Colors.green,
          fontSize: 14.0,
        );
      }
    } on DioException catch (e) {
      print(e.response!.data);
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);
      print(errorResponse.message);
      setState(() {
        _isCreateError = true;
        _registrationErrorMessage = errorResponse.message;
      });
    }

    print("WILL SUBMIT!!");
  }

  resetEkycForm() async {
    _firstNameController.clear();
    _lastNameController.clear();
    _presentAddController.clear();
    _permanentAddController.clear();
    _mobileNoController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _confirmController.clear();
    _emailController.clear();
    _birthdateController.clear();
  }

  @override
  void initState() {
    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmFocus = FocusNode();
    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _presentAddFocus = FocusNode();
    _permanentAddFocus = FocusNode();
    _mobileNoFocus = FocusNode();
    _birthdateFocus = FocusNode();
    // _usernameController.text = "Kolya0001";
    // _passwordController.text = "Password@123";

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    // Retrieve the access token from the provider and assign it to _accessToken
    _accessToken = accessTokenProvider.authToken?.accessToken ?? '';

    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _presentAddFocus.dispose();
    _permanentAddFocus.dispose();
    _mobileNoFocus.dispose();
    _birthdateFocus.dispose();

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
                  PopupMenuButton<String>(
                    offset: const Offset(0, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 0.1,
                      ), // Border color
                    ),
                    tooltip: "Click to view",
                    color: Colors.white,
                    elevation: 0,
                    position: PopupMenuPosition.under,
                    child: Text(
                      "Reports",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 12.0,
                      ),
                    ),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'check_ins',
                        child: Text(
                          'Check ins',
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'service_usages',
                        child: Text(
                          'Service usages',
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'transactions',
                        child: Text(
                          'Transactions',
                          style: GoogleFonts.urbanist(
                            color: AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      switch (value) {
                        case 'check_ins':
                          Navigator.pushReplacementNamed(
                            context,
                            "/a/report/checkins",
                          );
                          break;
                        case 'service_usages':
                          Navigator.pushReplacementNamed(
                            context,
                            "/a/report/service-usage",
                          );
                          break;
                        case 'transactions':
                          Navigator.pushReplacementNamed(
                            context,
                            "/a/report/transactions",
                          );
                          break;
                        default:
                          break;
                      }
                    },
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
                          controller: _usernameController,
                          focusNode: _usernameFocus,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Username",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.id_card_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
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
                          controller: _emailController,
                          focusNode: _emailFocus,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Email",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.mail_open_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _mobileNoController,
                          focusNode: _mobileNoFocus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Mobile No.",
                            prefixText: '+63',
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.call_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            fillColor: _isCreateError || !_isPasswordMatched
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Password",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError || !_isPasswordMatched
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.lock_closed_outline,
                              size: 18.0,
                              color: _isCreateError || !_isPasswordMatched
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Ionicons.eye_outline
                                    : Ionicons.eye_off_outline,
                                size: 18.0,
                                color: _isCreateError || !_isPasswordMatched
                                    ? AppColors.danger
                                    : AppColors.primary,
                              ),
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError || !_isPasswordMatched
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _confirmController,
                          focusNode: _confirmFocus,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: _isCreateError || !_isPasswordMatched
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Confirm",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError || !_isPasswordMatched
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.lock_closed_outline,
                              size: 18.0,
                              color: _isCreateError || !_isPasswordMatched
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError || !_isPasswordMatched
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "First name",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.person_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Last name",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.person_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _birthdateController,
                          focusNode: _birthdateFocus,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Birthdate YYYY/MM/DD",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.calendar_clear_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _presentAddController,
                          focusNode: _presentAddFocus,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Present Address",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.map_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
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
                          controller: _permanentAddController,
                          focusNode: _permanentAddFocus,
                          decoration: InputDecoration(
                            fillColor: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            labelText: "Permanent Address",
                            labelStyle: GoogleFonts.urbanist(
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary.withOpacity(0.5),
                              fontSize: 10.0,
                            ),
                            prefixIcon: Icon(
                              Ionicons.map_outline,
                              size: 18.0,
                              color: _isCreateError
                                  ? AppColors.danger
                                  : AppColors.primary,
                            ),
                            prefixIconColor: AppColors.primary,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                          style: TextStyle(
                            color: _isCreateError
                                ? AppColors.danger
                                : AppColors.primary,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                _registrationErrorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          _registrationErrorMessage,
                          style: GoogleFonts.urbanist(
                            color: AppColors.danger,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const Spacer(),
                OutlinedButton(
                  onPressed: () async {
                    resetEkycForm();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Reset',
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary, // Text color
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    handleCreateEkyc();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Create Staff Account',
                        style: GoogleFonts.urbanist(
                          color: AppColors.secondary,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
