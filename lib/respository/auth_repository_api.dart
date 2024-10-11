import 'package:shared_preferences/shared_preferences.dart';
import 'package:twongere/modules/User.dart';
import 'package:twongere/respository/auth_repository_base.dart';
import 'package:http/http.dart' as http;
import 'package:twongere/util/app_constansts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthRepositoryApi implements AuthRepositoryBase {
  final storage = const FlutterSecureStorage();

  @override
  Future<int> login({required String email, required String password}) async {
    final uri = Uri.parse(AppConstansts.login);

    final payload = {
      "email": email,
      "password": password,
    };

    try {
      final res = await http.post(uri, body: payload);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);

        final token = data['token'];
        final user = data['user'];
        final id = user['id']; // Extract the user ID
        final userName = user['name']; // Extract the user name
        final userEmail = user['email']; // Extract the user email

        // await saveToken(token);
        await storage.write(key: 'auth_token', value: token);
        await storage.write(
            key: 'id', value: id.toString()); // Save ID as string
        await storage.write(key: 'name', value: userName);
        await storage.write(key: 'email', value: userEmail);

        print(
            "::::::::::>> Logged in successfull:   ${res.statusCode}  ${res.body}");
        return 1;
      } else if (res.statusCode == 404) {
        print("::::::::::>> User not found   ${res.statusCode}  ${res.body}");
        return 0;
      } else if (res.statusCode == 401) {
        print(
            "::::::::::>> Invalid Credentials   ${res.statusCode}  ${res.body}");
        return -1;
      } else {
        print("::::::::::>> Failed to login   ${res.statusCode}  ${res.body}");
        return -2;
      }
    } catch (err) {
      print(">>>>>>>> Error loging in >>> $err");
      return 1;
    }
  }

  @override
  Future<int> verifyEmail({required String email, required String otp}) async {
    final uri = Uri.parse(AppConstansts.verifyEmail);

    final payload = {"email": email};

    try {
      final res = await http.post(uri, body: payload);

      if (res.statusCode == 200 || res.statusCode == 201) {
        print(
            "::::::::::>> Email verified successfully:   ${res.statusCode}  ${res.body}");
        return 1;
      } else {
        print(
            "::::::::::>> Failed verify email    ${res.statusCode}  ${res.body}");
        return 0;
      }
    } catch (err) {
      print("::::::::::>> Verifying email failed   $err");
      return 1;
    }
  }

  @override
  Future<int> signup({
    required String name,
    required String email,
    required String phone,
    required String password, required String organisation_name,


    // required String gender, required bool isDeaf
  }) async {
    final uri = Uri.parse(AppConstansts.signUp);

    final payload = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "product": "twogere",
      "organisation_name" : "Default"
      // "gender": gender,
      // "is_deaf": isDeaf.toString(),
    };

    try {
      final res = await http.post(uri,
          headers: {
            // 'Content-Type': 'application/json',
            // Set the content type to JSON
            'Authorization': 'Bearer YOUR_API_KEY',
            // If needed, add authentication headers
          },
          body: payload);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);

        if (data['token'] != null) {
          await storage.write(key: 'auth_token', value: data['token']);
        }

        await storage.write(key: 'name', value: name);
        await storage.write(key: 'email', value: email);
        // await storage.write(key: 'profile_image', value: profile_image);

        print("User Registered successfully:");
        print("Name: ${name}");
        print("Email: ${email}");

        print(
            "::::::::::>> User sign up successfull:   ${res.statusCode}  ${res.body}");
        return 1;
      } else if (res.statusCode == 422) {
        print(
            "::::::::::>> Account with email already exists    ${res.statusCode}  ${res.body}");
        return -1;
      } else {
        print(
            "::::::::::>> Failed to signup    ${res.statusCode}  ${res.body}");
        return 1;
      }
    } catch (err) {
      print(">>>>>>>> Error signing up >>> $err");
      return 1;
    }
    print(">>>>>>>> Wrong >Exception");
    return 1;
  }

  @override
  Future<User?> getProfile({required String token}) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove each key that was set during sign-up or login
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('gender');
    await prefs.remove('isDeaf');
    await prefs.remove('imagePath'); // If you want to clear the imagePath as well

    // Optional: You can also clear all data at once
    // await prefs.clear();
  }
}
