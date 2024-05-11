import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/registration.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/providers/registration.dart';
import 'package:furcarev2/widgets/gender_selection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CreateProfileStep1 extends StatefulWidget {
  const CreateProfileStep1({super.key});

  @override
  State<CreateProfileStep1> createState() => _CreateProfileStep1State();
}

class _CreateProfileStep1State extends State<CreateProfileStep1> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  late final FocusNode _firstNameFocus;
  late final FocusNode _lastNameFocus;

  // State
  String _selectedGender = "male";
  String _selectedBirthdate = "1999-01-01";

  Future handleSaveBasicInfo() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty) {
      _firstNameFocus.requestFocus();
      return;
    }
    if (lastName.isEmpty) {
      _lastNameFocus.requestFocus();
      return;
    }

    Provider.of<RegistrationProvider>(
      context,
      listen: false,
    ).setBasicInfo(
      BasicInfo(
        birthdate: _selectedBirthdate,
        firstName: firstName,
        gender: _selectedGender,
        lastName: lastName,
      ),
    );
    Navigator.pushNamed(
      context,
      '/c/create/profile/2',
    );
  }

  @override
  void initState() {
    super.initState();

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            size: 18.0,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          prefixIconColor: AppColors.primary,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.5),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            size: 18.0,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          prefixIconColor: AppColors.primary,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.5),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                      style: GoogleFonts.urbanist(
                        color: AppColors.primary.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 8.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GenderSelectionWidget(
                      onGenderSelected: (gender) {
                        setState(() {
                          _selectedGender = gender!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Birthday',
                style: GoogleFonts.urbanist(
                  color: AppColors.primary.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 8.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.single,
                      ),
                      value: const [],
                      onValueChanged: (dates) {
                        final String date = dates[0]!.toIso8601String();
                        _selectedBirthdate = date.substring(0, 10);
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (context.mounted) {
                    handleSaveBasicInfo();
                  }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: GoogleFonts.urbanist(
                            color: AppColors.secondary,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        const Icon(
                          Ionicons.arrow_forward_outline,
                          size: 12,
                        )
                      ],
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
