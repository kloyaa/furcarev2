import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CreateOwner extends StatefulWidget {
  const CreateOwner({super.key});

  @override
  State<CreateOwner> createState() => _CreateOwnerState();
}

class _CreateOwnerState extends State<CreateOwner> {
  final TextEditingController _workController = TextEditingController();
  final _emergenyNoController = MaskedTextController(mask: '0000-000-000');
  late final FocusNode _workFocus;
  late final FocusNode _emergenyNoFocus;

  // State
  bool _isCreateError = false;

  @override
  void initState() {
    super.initState();

    _workFocus = FocusNode();
    _emergenyNoFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _workFocus.dispose();
    _emergenyNoFocus.dispose();
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
            children: [
              const SizedBox(height: 50.0),
              Text(
                "We want to know you more!",
                style: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "finish your owner profile",
                style: GoogleFonts.urbanist(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  controller: _workController,
                  focusNode: _workFocus,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
                    labelText: "Work",
                    labelStyle: GoogleFonts.urbanist(
                      color: _isCreateError
                          ? AppColors.danger
                          : AppColors.primary.withOpacity(0.5),
                      fontSize: 10.0,
                    ),
                    prefixIcon: Icon(
                      Ionicons.briefcase_outline,
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
                  controller: _emergenyNoController,
                  focusNode: _emergenyNoFocus,
                  decoration: InputDecoration(
                    fillColor: AppColors.primary,
                    labelText: "Emergency No.",
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
                  if (context.mounted) {
                    // handleSaveBasicInfo();
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
                          'Save',
                          style: GoogleFonts.urbanist(
                            color: AppColors.secondary,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        const Icon(
                          Ionicons.checkbox_outline,
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
