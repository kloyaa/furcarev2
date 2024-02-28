import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ScreenAdminLogin extends StatefulWidget {
  const ScreenAdminLogin({super.key});

  @override
  State<ScreenAdminLogin> createState() => _ScreenAdminLoginState();
}

class _ScreenAdminLoginState extends State<ScreenAdminLogin> {
  // State
  bool _isPasswordVisible = false;

  Future<void> _handleLogin() async {
    showSnackBar(context, "Hello!");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.secondary,
        body: Center(
          child: SizedBox(
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "furcare",
                  style: GoogleFonts.sunshiney(
                    color: AppColors.primary,
                    fontSize: 90.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '"fur every pet needs"',
                  style: GoogleFonts.sunshiney(
                    color: AppColors.primary,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                    height: 0.1,
                  ),
                ),
                const SizedBox(height: 100.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    // controller: _usernameController,
                    // focusNode: _usernameFocus,
                    decoration: InputDecoration(
                      fillColor: AppColors.primary,
                      labelText: "Username or Email",
                      labelStyle: GoogleFonts.urbanist(
                        color: AppColors.primary.withOpacity(0.5),
                        fontSize: 10.0,
                      ),
                      prefixIcon: const Icon(
                        Ionicons.person_outline,
                        size: 18.0,
                        color: AppColors.primary,
                      ),
                      prefixIconColor: AppColors.primary,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                    ),
                    style: const TextStyle(
                      color: AppColors.primary,
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
                    // controller: _passwordController,
                    // focusNode: _passwordFocus,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Password",
                      labelStyle: GoogleFonts.urbanist(
                        color: AppColors.primary.withOpacity(0.5),
                        fontSize: 10.0,
                      ),
                      prefixIcon: const Icon(
                        Ionicons.lock_closed_outline,
                        size: 18.0,
                        color: AppColors.primary,
                      ),
                      prefixIconColor: AppColors.primary,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
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
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        color: AppColors.primary, fontSize: 12.0),
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () async {
                    await _handleLogin();

                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return PopConfirm(
                    //       content: "ff",
                    //       onOk: () async {
                    //         print("CLICKED!");
                    //       },
                    //       title: "g",
                    //     );
                    //   },
                    // );
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
                        'Sign in',
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
