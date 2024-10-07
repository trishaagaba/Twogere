import 'package:twongere/modules/User.dart';

abstract interface class AuthRepositoryBase{

  ///
  ///login
  ///signup
  ///update profile
  ///get user profile
  ///
  
  Future<int> login({
    required String email,
    required String password
  });

  Future<int> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    // required String gender,
    // required bool isDeaf
  });

  Future<User?> getProfile({
    required String token
  });

  Future<int> verifyEmail({
    required String email,
    required String otp
  });

}