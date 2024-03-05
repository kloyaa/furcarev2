import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/classes/registration.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/user.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:furcarev2/classes/client.dart';
import 'package:furcarev2/providers/registration.dart';
import 'package:furcarev2/screens/success.dart';
import 'package:furcarev2/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class CreateProfileStep2 extends StatefulWidget {
  const CreateProfileStep2({super.key});

  @override
  State<CreateProfileStep2> createState() => _CreateProfileStep2State();
}

class _CreateProfileStep2State extends State<CreateProfileStep2> {
  final TextEditingController _presentController = TextEditingController();
  final TextEditingController _permanentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _mobileNoController = MaskedTextController(mask: '0000-000-000');

  late final FocusNode _presentFocus;
  late final FocusNode _permanentFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _mobileNoFocus;

  // State
  final bool _isCreateError = false;

  Future handleCreateProfile() async {
    final present = _presentController.text.trim();
    final permanent = _permanentController.text.trim();
    final email = _emailController.text.trim();
    final number = _mobileNoController.text;

    if (present.isEmpty) {
      _presentFocus.requestFocus();
      return;
    }
    if (permanent.isEmpty) {
      _permanentFocus.requestFocus();
      return;
    }
    if (email.isEmpty) {
      _emailFocus.requestFocus();
      return;
    }
    if (number.isEmpty) {
      _mobileNoFocus.requestFocus();
      return;
    }

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    final registrationProvider = Provider.of<RegistrationProvider>(
      context,
      listen: false,
    );

    final firstName = registrationProvider.basicInfo!.firstName;
    final lastName = registrationProvider.basicInfo!.lastName;
    final birthdate = registrationProvider.basicInfo!.birthdate;
    final gender = registrationProvider.basicInfo!.gender;

    Profile profile = Profile(
      firstName: firstName,
      lastName: lastName,
      birthdate: birthdate,
      gender: gender,
      address: Address(
        permanent: permanent,
        present: present,
      ),
      isActive: true,
      contact: Contact(
        email: email,
        number: "0${number.replaceAll('-', '')}",
      ),
    );

    ClientApi clientApi = ClientApi(
      accessTokenProvider.authToken?.accessToken ?? "",
    );

    try {
      Response response = await clientApi.createMeProfile(profile.toJson());

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(context, redirectPath: "/"),
          ),
        );
      }

      print(response.data);
    } on DioException catch (e) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);

      if (context.mounted) {
        showSnackBar(
          context,
          errorResponse.message,
          color: AppColors.danger,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _presentFocus = FocusNode();
    _permanentFocus = FocusNode();
    _emailFocus = FocusNode();
    _mobileNoFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _presentFocus.dispose();
    _permanentFocus.dispose();
    _emailFocus.dispose();
    _mobileNoFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.secondary,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  controller: _presentController,
                  focusNode: _presentFocus,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
                    labelText: "Present address",
                    labelStyle: GoogleFonts.urbanist(
                      color: _isCreateError
                          ? AppColors.danger
                          : AppColors.primary.withOpacity(0.5),
                      fontSize: 10.0,
                    ),
                    prefixIcon: Icon(
                      Ionicons.map_outline,
                      size: 18.0,
                      color:
                          _isCreateError ? AppColors.danger : AppColors.primary,
                    ),
                    prefixIconColor: AppColors.primary,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                  style: TextStyle(
                    color:
                        _isCreateError ? AppColors.danger : AppColors.primary,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  controller: _permanentController,
                  focusNode: _permanentFocus,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
                    labelText: "Permanent address",
                    labelStyle: GoogleFonts.urbanist(
                      color: _isCreateError
                          ? AppColors.danger
                          : AppColors.primary.withOpacity(0.5),
                      fontSize: 10.0,
                    ),
                    prefixIcon: Icon(
                      Ionicons.map_outline,
                      size: 18.0,
                      color:
                          _isCreateError ? AppColors.danger : AppColors.primary,
                    ),
                    prefixIconColor: AppColors.primary,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                  style: TextStyle(
                    color:
                        _isCreateError ? AppColors.danger : AppColors.primary,
                    fontSize: 12.0,
                  ),
                ),
              ),
              // Contact starts here
              const SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
                    labelText: "Email",
                    labelStyle: GoogleFonts.urbanist(
                      color: _isCreateError
                          ? AppColors.danger
                          : AppColors.primary.withOpacity(0.5),
                      fontSize: 10.0,
                    ),
                    prefixIcon: Icon(
                      Ionicons.mail_outline,
                      size: 18.0,
                      color:
                          _isCreateError ? AppColors.danger : AppColors.primary,
                    ),
                    prefixIconColor: AppColors.primary,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                  style: TextStyle(
                    color:
                        _isCreateError ? AppColors.danger : AppColors.primary,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  controller: _mobileNoController,
                  focusNode: _mobileNoFocus,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
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
                      color:
                          _isCreateError ? AppColors.danger : AppColors.primary,
                    ),
                    prefixIconColor: AppColors.primary,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                  style: TextStyle(
                    color:
                        _isCreateError ? AppColors.danger : AppColors.primary,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  handleCreateProfile();
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
                      'Submit',
                      style: GoogleFonts.urbanist(
                        color: AppColors.secondary,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () async {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Back",
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
