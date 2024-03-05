import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:furcarev2/classes/login_response.dart';
import 'package:furcarev2/consts/colors.dart';
import 'package:furcarev2/endpoints/auth.dart';
import 'package:furcarev2/providers/authentication.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ScreenCustomerLogin extends StatefulWidget {
  const ScreenCustomerLogin({super.key});

  @override
  State<ScreenCustomerLogin> createState() => _ScreenCustomerLoginState();
}

class _ScreenCustomerLoginState extends State<ScreenCustomerLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final FocusNode _usernameFocus;
  late final FocusNode _passwordFocus;

  // State
  bool _isPasswordVisible = false;
  bool _isLoginError = false;
  String _loginErrorMessage = "";

  Future<void> _handleLogin() async {
    final authenticationApi = AuthenticationApi("mobile");
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      _usernameFocus.requestFocus();
    }
    if (password.isEmpty) {
      _passwordFocus.requestFocus();
    }

    final accessTokenProvider = Provider.of<AuthTokenProvider>(
      context,
      listen: false,
    );

    try {
      Response response = await authenticationApi.login(
        username: username,
        password: password,
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      if (response.data["role"].toString().toLowerCase() != "customer") {
        setState(() {
          _isLoginError = true;
          _loginErrorMessage = "Please use the Furcare web app, Thank you.";
        });

        return;
      }

      setState(() {
        _isLoginError = false;
        _loginErrorMessage = "";
      });

      if (loginResponse.code == "00") {
        if (context.mounted) {
          accessTokenProvider.setAuthToken(loginResponse.accessToken);
          Navigator.pushReplacementNamed(context, '/c/main');
        }
      }
    } on DioException catch (e) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(e.response?.data);

      if (errorResponse.code == '0104') {
        if (context.mounted) {
          if (errorResponse.accessToken != null) {
            accessTokenProvider.setAuthToken(errorResponse.accessToken ?? "");
          }
          Navigator.pushReplacementNamed(context, '/c/create/profile/1');
        }
      }

      setState(() {
        _isLoginError = true;
        _loginErrorMessage = e.response!.data["message"];
      });
    }
  }

  @override
  void initState() {
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();

    _usernameController.text = "kolya01";
    _passwordController.text = "Password@1234";
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
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
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login to your account",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary,
                    fontSize: 18.0,
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
                    controller: _usernameController,
                    focusNode: _usernameFocus,
                    decoration: InputDecoration(
                      fillColor: AppColors.primary,
                      labelText: "Username or Email",
                      labelStyle: GoogleFonts.urbanist(
                        color: _isLoginError
                            ? AppColors.danger
                            : AppColors.primary.withOpacity(0.5),
                        fontSize: 10.0,
                      ),
                      prefixIcon: Icon(
                        Ionicons.person_outline,
                        size: 18.0,
                        color: _isLoginError
                            ? AppColors.danger
                            : AppColors.primary,
                      ),
                      prefixIconColor: AppColors.primary,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                    ),
                    style: TextStyle(
                      color:
                          _isLoginError ? AppColors.danger : AppColors.primary,
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
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Password",
                      labelStyle: GoogleFonts.urbanist(
                        color: _isLoginError
                            ? AppColors.danger
                            : AppColors.primary.withOpacity(0.5),
                        fontSize: 10.0,
                      ),
                      prefixIcon: Icon(
                        Ionicons.lock_closed_outline,
                        size: 18.0,
                        color: _isLoginError
                            ? AppColors.danger
                            : AppColors.primary,
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
                          color: _isLoginError
                              ? AppColors.danger
                              : AppColors.primary,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color:
                          _isLoginError ? AppColors.danger : AppColors.primary,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                _loginErrorMessage.isNotEmpty
                    ? Text(
                        _loginErrorMessage,
                        style: GoogleFonts.urbanist(
                          color: AppColors.danger,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
                Text(
                  "By logging in, you agree to abide by our terms and conditions. Please review them carefully before proceeding.",
                  style: GoogleFonts.urbanist(
                    color: AppColors.primary.withOpacity(0.7),
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 80.0),
                ElevatedButton(
                  onPressed: () async {
                    await _handleLogin();
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
                const SizedBox(height: 10.0),
                OutlinedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "/c/register");
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
                        "Don't have an account?",
                        style: GoogleFonts.urbanist(
                          color: AppColors.primary,
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
