import 'package:flutter/material.dart';
// Import necessary dependencies for HTTP requests
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isCodeSent = false;
  bool _isCodeVerified = false;

  Future<void> _sendResetCode() async {
    final String email = _emailController.text;

    if (email.isNotEmpty) {
      // Make an API call to send the reset code to the email
      var response = await http.post(
        Uri.parse('https://api.cognospheredynamics.com/api/auth/sendVerifyResetEmail'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isCodeSent = true;
        });
      } else {
        // Handle error here
        print("Failed to send reset code: ${response.body}");
      }
    }
  }

  Future<void> _verifyResetCode() async {
    final String email = _emailController.text;
    final String resetCode = _codeController.text;

    if (resetCode.isNotEmpty) {
      // Verify the code
      var response = await http.post(
        Uri.parse('https://api.cognospheredynamics.com/api/auth/verifyingResetEmail'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'reset_code': resetCode,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isCodeVerified = true;
        });
      } else {
        // Handle error
        print("Failed to verify code: ${response.body}");
      }
    }
  }

  Future<void> _resetPassword() async {
    final String email = _emailController.text;
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (newPassword == confirmPassword && newPassword.isNotEmpty) {
      // Make API call to reset password
      var response = await http.post(
        Uri.parse('https://api.cognospheredynamics.com/api/auth/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully reset password
        Navigator.pop(context); // Close the dialog
      } else {
        // Handle error
        print("Failed to reset password: ${response.body}");
      }
    } else {
      print("Passwords do not match or are empty.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isCodeSent
          ? (_isCodeVerified ? "Reset Password" : "Enter Verification Code")
          : "Forgot Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isCodeSent)
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
              ),
            ),
          if (_isCodeSent && !_isCodeVerified)
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter the code sent to your email',
              ),
            ),
          if (_isCodeVerified) ...[
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!_isCodeSent) {
              _sendResetCode();
            } else if (_isCodeSent && !_isCodeVerified) {
              _verifyResetCode();
            } else if (_isCodeVerified) {
              _resetPassword();
            }
          },
          child: Text(_isCodeSent
              ? (_isCodeVerified ? "Reset Password" : "Verify Code")
              : "Send Code"),
        ),
      ],
    );
  }
}
