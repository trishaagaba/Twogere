import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:twongere/respository/auth_repository_api.dart';

void main(){

  group("User Auth", (){
    test("Login test", ()async{
      const String email = "andruajoshua096@gmail.com";
      const String password = "123456";

      final res = await AuthRepositoryApi().login(
        email: email, 
        password: password, );

      expect(1, res, reason: "Testing login");

    });

    test("Signup test", ()async{
      const String name = "Drillox _TT";
      const String email = "andruajoshua0960@gmail.com";
      const String phone = "770415425";
      const String password = "123456";
      const String gender = "male";
      const bool isDeaf = false;

      final res = await AuthRepositoryApi().signup(
        name: name, email: email, 
        phone: phone, password: password, organisation_name: '',
        // gender: gender, isDeaf: isDeaf
      );

      expect(1, res, reason: "Testing signup");

    });

    test("Login test", ()async{

    });

  });

}