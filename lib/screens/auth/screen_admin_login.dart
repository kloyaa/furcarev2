import 'package:flutter/material.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';

class ScreenAdminLogin extends StatefulWidget {
  const ScreenAdminLogin({super.key});

  @override
  State<ScreenAdminLogin> createState() => _ScreenAdminLoginState();
}

class _ScreenAdminLoginState extends State<ScreenAdminLogin> {
  // State
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.secondary,
        body: Center(
          child: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Furcare",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
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
                      prefixIcon: const HeroIcon(HeroIcons.user),
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
                      prefixIcon: const HeroIcon(HeroIcons.lockClosed),
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
                        child: HeroIcon(
                          _isPasswordVisible
                              ? HeroIcons.eye
                              : HeroIcons.eyeSlash,
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
                    // await login(context);
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
