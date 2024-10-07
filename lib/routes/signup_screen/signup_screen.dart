import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twongere/respository/auth_repository_api.dart';
import 'package:twongere/route.dart';
import 'package:twongere/routes/login_screen/widgets/login_screen_widgets.dart';
import 'package:twongere/util/app_buttons.dart';
import 'package:twongere/util/app_colors.dart';
import 'package:twongere/util/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  Future<void> _storeUserDataLocally(String name, String email, String phone, String gender, bool isDeaf) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('gender', gender);
    await prefs.setBool('isDeaf', isDeaf);
  }
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hasConsented = false;
  bool _isDeaf = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _gender;
  late final TextEditingController _genderController = TextEditingController();

  final AuthRepositoryApi authRepositoryApi = AuthRepositoryApi();

  final _formKey = GlobalKey<FormState>();

  String? _uploadedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _uploadedImage = result.files.first.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Let's get you started!",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppStyles.normalPrimaryColorTxtStyle.color,
          ),
        ),
      ),
      body: SafeArea(
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                child : SingleChildScrollView(

                 padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                      // Profile picture picker
                          child: Column(
                          children: [
                            _uploadedImage != null
                            ? CircleAvatar(
                            radius: 50,
                              // backgroundColor: Colors.grey,
                            backgroundImage: FileImage(File(_uploadedImage!)),
                          )
                              : const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _pickImage,
                          child: const Text("Upload Profile Picture", style: AppStyles.normalPrimaryColorTxtStyle),
                        ),
                        ],
                      ),
                    ),
                      const SizedBox(height: 20),

                      const Text("Full Name", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _nameController,
                        hintText: "Full Name",
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        isOutlined: false, // Render as underline only
                        outlineColor: AppColors.primarColor,

                      ),
                      const SizedBox(height: 20),

                      const Text("Email Address", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _emailController,
                        hintText: "yourname@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        isOutlined: false, // Render as underline only
                        outlineColor: AppColors.primarColor,
                      ),
                      const SizedBox(height: 20),

                      const Text("Phone Number", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      PhoneInputWidget(
                        controller: _phoneController,
                        hintText: "Enter your phone number",
                        keyboardType: TextInputType.phone,
                        isPassword: false,
                        isOutlined: false, // Render as underline only
                        outlineColor: AppColors.primarColor,
                      ),
                      const SizedBox(height: 20),

                      const Text("Gender", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: _gender,
                        items: [
                          DropdownMenuItem(value:"Female", child: Text("Female")),
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _gender = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primarColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text("Do you have any impairements?", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<bool>(
                        value: _isDeaf,
                        items: [
                          DropdownMenuItem(value: true, child: Text("Yes, I am deaf.")),
                          DropdownMenuItem(value: false, child: Text("No, i do not have")),
                        ],
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isDeaf = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primarColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text("Password", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _passwordController,
                        hintText: "Please enter your password",
                        isPassword: !_isPasswordVisible, // Toggle between obscured and visible text
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.primarColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                            });
                          },
                        ),
                        isOutlined: false, // Render as underline only
                        outlineColor: AppColors.primarColor,
                      ),
                      const SizedBox(height: 20),

                      const Text("Confirm Password", style: AppStyles.normalPrimaryColorTxtStyle),
                      const SizedBox(height: 5),
                      TextInputWidget(
                        controller: _confirmPasswordController,
                        hintText: "Confirm your password",
                        isPassword: !_isPasswordVisible, // Toggle between obscured and visible text
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.primarColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                            });
                          },
                        ),
                        isOutlined: false, // Render as underline only
                        outlineColor: AppColors.primarColor,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Checkbox(
                            value: _hasConsented,
                            onChanged: (bool? value) {
                              setState(() {
                                _hasConsented = value ?? false;
                              });
                            },
                          ),
                    Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'I agree to the ',
                                    style: TextStyle(
                                        color: Colors
                                            .black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context:
                                          context,
                                          builder:
                                              (BuildContext
                                          context) {
                                            return Container(
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              child: AlertDialog(
                                                  title: Text(
                                                      "Terms and Conditions"),
                                                  content:
                                                  SingleChildScrollView(
                                                      child: Text(
                                                        '''Welcome to Twogere!
                                                              
                                                              These Terms and Conditions ("Terms", "Agreement") govern your use of the Twogere mobile application ("App") and the services provided through it. By accessing or using the App, you agree to be bound by these Terms. If you do not agree to any part of the Terms, you may not use the App.
                                                              
                                                              1. Acceptance of Terms
                                                              By using Twogere, you confirm that you have read, understood, and agreed to these Terms and our Privacy Policy.
                                                              
                                                              2. Description of Services
                                                              Twogere provides a platform that facilitates communication for the deaf and supports job opportunities for the deaf community. Users can communicate with others, connect with organizations, and explore job listings tailored for deaf individuals and inclusive employers.
                                                              
                                                              3. User Accounts
                                                              You may need to create an account to access certain features of Twogere. You agree to provide accurate and up-to-date information during registration and keep it updated. You are responsible for maintaining the confidentiality of your account details and for all activities under your account.
                                                              
                                                              4. Payments and Premium Upgrades
                                                              Twogere offers a premium version with enhanced features, such as priority support and advanced job-matching services. Payments for premium services are processed through third-party providers. By submitting your payment information, you authorize Twogere to charge you for the selected premium services. All payments are final and non-refundable unless required by law.
                                                              
                                                              5. Job Listings and Communication Features
                                                              Twogere provides tools for easy communication between the deaf and hearing individuals, as well as listings of job opportunities from organizations supporting inclusive hiring. While we strive for accuracy, Twogere does not guarantee the completeness of any job listing or communication service provided.
                                                              
                                                              6. Third-Party Services
                                                              Twogere may include links to third-party websites or services. We do not control or endorse these services and are not responsible for their content, privacy policies, or practices.
                                                              
                                                              7. User Conduct
                                                              You agree to use Twogere responsibly and not engage in any illegal or inappropriate activities. You must not attempt to interfere with the App’s security features or misuse its functionality.
                                                              
                                                              8. Intellectual Property
                                                              All content on Twogere, including text, graphics, logos, and software, is owned by Twogere or its licensors. You may not copy, modify, or distribute any content without permission.
                                                              
                                                              9. Limitation of Liability
                                                              Twogere is not responsible for any direct or indirect damages resulting from your use of the App. We do not guarantee uninterrupted service or error-free functionality.
                                                              
                                                              10. Termination
                                                              We reserve the right to suspend or terminate your account if we believe you have violated these Terms or engaged in improper behavior.
                                                              
                                                              11. Changes to Terms
                                                              Twogere may update these Terms at any time. Significant changes will be communicated via the App or email. Continued use of the App after changes signifies acceptance of the updated Terms.
                                                              
                                                              12. Governing Law
                                                              These Terms are governed by the laws of [Your Country].
                                                              
                                                              13. Contact Us
                                                              If you have any questions about these Terms, please contact us.''',
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          14,
                                                          fontFamily:
                                                          'Plus Jakarta Sans',
                                                          color:
                                                          Colors.black,
                                                          // Adjust the text style as needed
                                                        ),
                                                      )),
                                                                                  actions: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Checkbox(
                                              value: _hasConsented,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _hasConsented = value ?? false;
                                                });
                                              },
                                                                                        ),
                                                                                        Text('I agree'),
                                                                                      ],
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        setState(() {
                                              _hasConsented = true;
                                                                                        });
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: Text("Back"),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                            );
                                },
                              );
                            },
                            child:
                            Text("Terms and Conditions",
                              style: TextStyle(
                                      color:
                                      Colors.blue,
                                      decoration:
                                      TextDecoration
                                          .underline, ),),
                                    )])),]),
                      const SizedBox(height: 20),
                      _isLoading
                          ? Center(child: const CircularProgressIndicator() ) // Show loader when logging in
                          :
                      CorneredButton(
                        label: "Sign Up",
                        bgColor: AppColors.primarColor,
                        txtColor: AppColors.whiteColor,
                        onClick: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          final storage = FlutterSecureStorage();

                          Future<void> _storeUserDataLocally(String name, String email, String phone, String gender, bool isDeaf) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('name', name);
                            await prefs.setString('email', email);
                            await prefs.setString('phone', phone);
                            await prefs.setString('gender', gender);
                            await prefs.setBool('isDeaf', isDeaf);

                            String? imagePath = _uploadedImage;
                            if (imagePath != null) {
                              await prefs.setString('profile_image', imagePath);
                            }

                            // if (_uploadedImage != null) {
                            //   await storage.write(key: 'profile_image', value: _uploadedImage);
                            // }
                          }
                          setState(() {
                            _isLoading = false;
                          });

                          if (!_hasConsented) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please agree to the Terms and Conditions."),
                              ),
                            );
                            return;
                          }

                          // Validate that all fields are filled
                          if (_nameController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _phoneController.text.isEmpty ||
                              _passwordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty
                          // ||
                              // _genderController.text.isEmpty
                          )
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill in all fields."),
                              ),
                            );
                            return;
                          }

                          // Check if passwords match
                          if (_passwordController.text != _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Passwords do not match."),
                              ),
                            );
                            return;
                          }

                          // Sign up process
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          String name = _nameController.text;
                          String phone = _phoneController.text;
                          String gender = _genderController.text;
                          bool isDeaf = _isDeaf;

                          String? imagePath = _uploadedImage;

                          // Call the signup method and handle the response
                          int result = await authRepositoryApi.signup(
                            name: name,
                            email: email,
                            phone: phone,
                            password: password,
                            // gender: gender,
                            // isDeaf: isDeaf,
                          );

                          if (result == 1) {
                            await _storeUserDataLocally(name, email, phone, gender, isDeaf);

                            // User signed up successfully, inform them about verification
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Signup successful."),
                              ),
                            );
                            // Navigate to the OTP verification screen or home screen
                            Navigator.pushNamed(context, RoutesGenerator.homeScreen);
                          } else {
                            // Handle different error responses
                            String errorMessage;

                            switch (result) {
                              case -1:
                                errorMessage = "Account with email already exists.";
                                break;
                              case 0:
                                errorMessage = "Signup failed. Please try again.";
                                break;
                              // case -3:
                              //   errorMessage = "Network error. Please check your connection.";
                                break;
                              default:
                                errorMessage = "An unexpected error occurred.";
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                    )
                    ),
              )
                              ]),
                            )
    );

     }
}