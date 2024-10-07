import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // To store login state
import 'package:twongere/route.dart';
import 'package:twongere/routes/login_screen/widgets/login_screen_widgets.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import '../../respository/auth_repository_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepositoryApi authRepositoryApi = AuthRepositoryApi();

  bool isChecked = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLoginState(); // Load saved login state
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Load login details if "Remember Me" was checked previously
  Future<void> _loadLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (email != null && password != null) {
      // If there are saved credentials, navigate to home screen directly
      // Navigator.pushReplacementNamed(context, RoutesGenerator.homeScreen);
    } else {
      setState(() {
        _emailController.text = email ?? '';
        _passwordController.text = password ?? '';
        isChecked = prefs.getBool('remember_me') ?? false;
      });
    }
  }

  // Save login details when "Remember Me" is checked
  Future<void> _saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('remember_me');
    }
  }

  Future<void> _handleLogin() async {
  if (isChecked) {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('remember_me', true); // Save "Remember Me" status
  } else {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('remember_me', false); // Clear "Remember Me" status
  }

  Navigator.pushReplacementNamed(context, RoutesGenerator.homeScreen); // Navigate to Home after login
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Hi, Welcome!",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppStyles.normalPrimaryColorTxtStyle.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email",
                          style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _emailController,
                        hintText: "yourname@gmail.com",
                        isPassword: false,
                        isOutlined: false,
                        outlineColor: AppColors.primarColor,
                        // Single line input with underline
                      ),
                      const SizedBox(height: 20),
                      const Text("Password",
                          style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _passwordController,
                        hintText: "Password",
                        isPassword: true,
                        isOutlined: false,
                        outlineColor: AppColors
                            .primarColor, // Single line input with underline
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                activeColor: AppColors.primarColor,
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                              const Text("Remember Me",
                                  style: AppStyles.normalBlackTxtStyle),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text("Forgot Password?",
                      //       style: AppStyles.normalPrimaryColorTxtStyle),
                      // ),
                      const SizedBox(height: 50),
                      _isLoading
                          ? Center(
                              child:
                                  const CircularProgressIndicator()) // Show loader when logging in
                          : CorneredButton(
                              label: "Login",
                              bgColor: AppColors.primarColor,
                              txtColor: AppColors.whiteColor,
                              onClick: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                int loginResult = await authRepositoryApi.login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                setState(() {
                                  _isLoading =
                                      false; // Stop the loading indicator
                                });


                                if (loginResult == 1) {
                                  // Successful login
                                  await _saveLoginState(); // Save login details if "Remember Me" is checked
                                  Navigator.pushNamed(
                                      context, RoutesGenerator.homeScreen);
                                } else if (loginResult == 0) {
                                  _showMessageDialog(
                                    context,
                                    "User Not Found",
                                    "We couldn't find an account associated with that email. Would you like to create a new account?",
                                  );
                                } else if (loginResult == -1) {
                                  _showMessageDialog(
                                    context,
                                    "Invalid Credentials",
                                    "The email or password you entered is incorrect. Please try again.",
                                  );
                                } else if (loginResult == -2) {
                                  _showMessageDialog(
                                    context,
                                    "Login Failed",
                                    "Something went wrong while logging in. Please try again later.",
                                  );
                                }
                                else if (loginResult == -3) {
                                  _showMessageDialog(
                                    context,
                                    "Network Error",
                                    "Could not connect to the server. Please check your internet connection and try again.",
                                  );
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?",
                              style: AppStyles.normalGreyColorTxtStyle),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, RoutesGenerator.signupScreen),
                            child: const Text("Sign Up",
                                style: AppStyles.normalPrimaryColorTxtStyle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

void _showMessageDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

